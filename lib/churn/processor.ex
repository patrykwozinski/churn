defmodule Churn.Processor do
  @moduledoc false

  alias Churn.File
  alias Churn.Processor.CyclomaticComplexity
  alias Churn.Processor.Result
  alias Churn.Processor.TimesEdited

  @spec process(File.t()) :: {:ok, Result.t()}
  def process(%File{} = file) do
    cyclomatic_complexity = CyclomaticComplexity.calculate(file)
    times_changed = TimesEdited.calculate(file)

    {:ok, Result.build(file, cyclomatic_complexity, times_changed)}
  end
end
