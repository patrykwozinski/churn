defmodule Mix.Tasks.Churn do
  use Mix.Task

  @shortdoc """
  Run churn analysis of specified directories

  Available options:
  --min-score-to-show 1 [-s]
  --commit-since "1 year ago" [-c]
  --directories-to-scan "lib,test" [-d]
  --file-extensions "ex,exs" [-e]
  """
  @moduledoc @shortdoc

  @doc false
  def run(args) do
    Churn.CLI.main(args)
  end
end
