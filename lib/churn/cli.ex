defmodule Churn.CLI do
  @moduledoc """
  `Churn.CLI` is the entrypoint for both the Mix task and the escript.
  """

  @doc """
  Runs Churn with the given `args` and exits the process.
  """
  def main(args \\ []) do
    Churn.run(args)
  end
end
