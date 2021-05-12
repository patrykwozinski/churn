defmodule Churn.Renderer do
  @moduledoc false

  alias Churn.Processor.Result
  alias Churn.Renderer.Console

  @spec render([Result.t()], :console) :: :ok
  def render(results, output \\ :console) do
    case output do
      :console -> Console.render(results)
      _ -> :ok
    end
  end
end
