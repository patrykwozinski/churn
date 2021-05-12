defmodule Churn.Processor.TimesEdited do
  @moduledoc false

  alias Churn.File

  @spec calculate(File.t()) :: pos_integer()
  def calculate(%File{path: _file_path}) do
    0
  end
end
