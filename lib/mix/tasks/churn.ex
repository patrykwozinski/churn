defmodule Mix.Tasks.Churn do
  use Mix.Task

  @shortdoc """
  Run churn analysis of specified directories

  Available options:
  --min-score-to-show 1
  --commit-since "1 year ago"
  --directories-to-scan "lib,test"
  --file-extensions "ex,exs"
  """
  @moduledoc @shortdoc

  @doc false
  def run(args) do
    Churn.CLI.main(args)
  end
end
