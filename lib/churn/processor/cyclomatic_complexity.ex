defmodule Churn.Processor.CyclomaticComplexity do
  @moduledoc """
  Cyclomatic Complexity calulator, source code based (stolen?) from:
  https://github.com/rrrene/credo/blob/master/lib/credo/check/refactor/cyclomatic_complexity.ex
  """

  alias Churn.File, as: ChurnFile

  @spec calculate(ChurnFile.t()) :: pos_integer()
  def calculate(%ChurnFile{path: file_path}) do
    file_path
    |> File.read!()
    |> Code.string_to_quoted!()
    |> complexity_for()
  end

  @def_ops [:def, :defp, :defmacro]
  # these have two outcomes: it succeeds or does not
  @double_condition_ops [:if, :unless, :for, :try, :and, :or, :&&, :||]
  # these can have multiple outcomes as they are defined in their do blocks
  @multiple_condition_ops [:case, :cond]
  @op_complexity_map [
    def: 1,
    defp: 1,
    defmacro: 1,
    if: 1,
    unless: 1,
    for: 1,
    try: 1,
    and: 1,
    or: 1,
    &&: 1,
    ||: 1,
    case: 1,
    cond: 1
  ]

  defp complexity_for({_def_op, _meta, _arguments} = ast) do
    prewalk(ast, &traverse_complexity/2, 0)
  end

  for op <- @def_ops do
    defp traverse_complexity(
           {unquote(op) = op, _meta, arguments} = ast,
           complexity
         )
         when is_list(arguments) do
      {ast, complexity + @op_complexity_map[op]}
    end
  end

  for op <- @double_condition_ops do
    defp traverse_complexity(
           {unquote(op) = op, _meta, arguments} = ast,
           complexity
         )
         when is_list(arguments) do
      {ast, complexity + @op_complexity_map[op]}
    end
  end

  for op <- @multiple_condition_ops do
    defp traverse_complexity({unquote(op), _meta, nil} = ast, complexity) do
      {ast, complexity}
    end

    defp traverse_complexity(
           {unquote(op) = op, _meta, arguments} = ast,
           complexity
         )
         when is_list(arguments) do
      block_cc =
        arguments
        |> do_block_for!()
        |> do_block_complexity(op)

      {ast, complexity + block_cc}
    end
  end

  defp traverse_complexity(ast, complexity) do
    {ast, complexity}
  end

  defp do_block_complexity(nil, _), do: 0

  defp do_block_complexity(block, op) do
    count =
      block
      |> List.wrap()
      |> Enum.count()

    count * @op_complexity_map[op]
  end

  defp prewalk(source_ast, fun, accumulator) do
    {_, accumulated} = Macro.prewalk(source_ast, accumulator, fun)

    accumulated
  end

  def do_block?(ast) do
    case do_block_for(ast) do
      {:ok, _block} ->
        true

      nil ->
        false
    end
  end

  def do_block_for!(ast) do
    case do_block_for(ast) do
      {:ok, block} ->
        block

      nil ->
        nil
    end
  end

  defp do_block_for({_atom, _meta, arguments}) when is_list(arguments) do
    do_block_for(arguments)
  end

  defp do_block_for(do: block) do
    {:ok, block}
  end

  defp do_block_for(arguments) when is_list(arguments) do
    Enum.find_value(arguments, &find_keyword(&1, :do))
  end

  defp do_block_for(_) do
    nil
  end

  defp find_keyword(list, keyword) when is_list(list) do
    if Keyword.has_key?(list, keyword) do
      {:ok, list[keyword]}
    else
      nil
    end
  end

  defp find_keyword(_, _), do: nil
end
