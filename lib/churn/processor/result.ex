defmodule Churn.Processor.Result do
  @moduledoc false

  use TypedStruct

  alias Churn.File

  typedstruct enforce: true do
    field(:file, File.t())
    field(:complexity, pos_integer())
    field(:times_changed, non_neg_integer())
  end

  @spec build(File.t(), pos_integer(), non_neg_integer()) :: t()
  def build(file, complexity, times_changed) do
    %__MODULE__{file: file, complexity: complexity, times_changed: times_changed}
  end
end
