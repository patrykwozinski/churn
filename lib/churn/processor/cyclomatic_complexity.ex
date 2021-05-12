defmodule Churn.Processor.CyclomaticComplexity do
  @moduledoc false

  alias Churn.File

  @spec calculate(File.t()) :: pos_integer()
  def calculate(%File{path: _file_path}) do
    1
  end
end
