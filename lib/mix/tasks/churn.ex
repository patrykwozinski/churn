defmodule Mix.Tasks.Churn do
  use Mix.Task

  @shortdoc "Run churn analysis"
  @moduledoc @shortdoc

  @doc false
  def run(args) do
    Churn.CLI.main(args)
  end
end
