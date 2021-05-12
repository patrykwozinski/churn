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
    |> TableRex.quick_render!(header, @title)
  end
end
