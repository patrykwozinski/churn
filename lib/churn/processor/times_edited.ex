defmodule Churn.Processor.TimesEdited do
  @moduledoc false

  alias Churn.File

  @spec calculate(File.t(), String.t()) :: pos_integer()
  def calculate(%File{path: file_path}, commits_since) do
    System.cmd("git", [
      "rev-list",
      "--since",
      "\"#{commits_since}\"",
      "--no-merges",
      "--count",
      "HEAD",
      file_path
    ])
    |> elem(0)
    |> Integer.parse()
    |> case do
      {number, "\n"} when is_integer(number) -> number
      _ -> 0
    end
  end
end
