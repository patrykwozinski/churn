defmodule Churn.Execution.Result do
  @moduledoc false

  use TypedStruct

  alias Churn.File

  typedstruct enforce: true do
    field(:file, File.t())
  end

  def build(%File{} = file, processing_response) do
  end
end
