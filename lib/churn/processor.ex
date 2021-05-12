defmodule Churn.Processor do
  @moduledoc false

  alias Churn.File
  alias Churn.Processor.Response

  @spec process(File.t()) :: {:ok, Response.t()}
  def process(%File{} = _file) do
    {:ok, Response.build(1, 0)}
  end
end
