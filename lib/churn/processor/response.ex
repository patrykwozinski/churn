defmodule Churn.Processor.Response do
  @moduledoc false

  use TypedStruct

  typedstruct enforce: true do
    field(:complexity, pos_integer())
    field(:times_changed, non_neg_integer())
  end

  @spec build(pos_integer(), non_neg_integer()) :: t()
  def build(complexity, times_changed) do
    %__MODULE__{complexity: complexity, times_changed: times_changed}
  end
end
