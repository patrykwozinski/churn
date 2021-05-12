defmodule Churn.File do
  @moduledoc false

  use TypedStruct

  typedstruct enforce: true do
    field(:path, String.t())
  end

  @spec build(String.t()) :: t()
  def build(path) do
    %__MODULE__{
      path: path
    }
  end
end
