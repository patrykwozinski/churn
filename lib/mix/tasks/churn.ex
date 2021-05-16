defmodule Mix.Tasks.Churn do
  use Mix.Task

  @shortdoc """
  Run churn analysis of specified directories\n\n

  Available options:
  \n--min-score-to-show 1 [-s]
  \n--commit-since "1 year ago" [-c]
  \n--directories-to-scan "lib,test" [-d]
  \n--file-extensions "ex,exs" [-e]
  \n--files-to-ignore "lib/churn/testing.ex" [-i]
  """
  @moduledoc @shortdoc

  @doc false
  def run(args) do
    Churn.CLI.main(args)
  end
end
