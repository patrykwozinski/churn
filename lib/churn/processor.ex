defmodule Churn.Processor do
  @moduledoc false

  alias Churn.File
  alias Churn.Processor.CyclomaticComplexity
  alias Churn.Processor.Result
  alias Churn.Processor.TimesEdited

  @spec process(File.t(), String.t()) :: {:ok, Result.t()}
  def process(%File{} = file, commit_since) do
    cyclomatic_complexity = CyclomaticComplexity.calculate(file)
    times_changed = TimesEdited.calculate(file, commit_since)

    {:ok, Result.build(file, cyclomatic_complexity, times_changed)}
  end
end
