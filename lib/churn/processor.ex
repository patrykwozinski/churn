defmodule Churn.Processor do
  @moduledoc false

  alias Churn.File
  alias Churn.Processor.Result

  @spec process(File.t()) :: {:ok, Result.t()}
  def process(%File{} = file) do
    {:ok, Result.build(file, 1, 0)}
  end
end
