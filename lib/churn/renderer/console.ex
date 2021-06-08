defmodule Churn.Renderer.Console do
  @moduledoc false

  alias Churn.Processor.Result

  @title "Churn :: Refactoring candidates"

  @spec render([Result.t()]) :: :ok
  def render(results) do
    header = ["File", "Times Changed", "Complexity", "Score"]

    results
    |> Enum.map(fn result ->
      [result.file.path, result.times_changed, result.complexity, result.score]
    end)
    |> do_render(header, @title)
  end

  defp do_render([] = _results, _header, _title) do
    IO.puts "(No results. Please try again with different options.)"
  end

  defp do_render(results, header, title) do
    results
    |> TableRex.quick_render!(header, title)
    |> IO.puts()
  end
end
