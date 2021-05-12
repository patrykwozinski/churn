defmodule Churn.Processor.TimesEdited do
  @moduledoc false

  alias Churn.File

  @spec calculate(File.t(), String.t()) ::
          {:ok, pos_integer()} | {:error, :can_not_calculate_total_edited}
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
      {number, "\n"} when is_integer(number) -> {:ok, number}
      _ -> {:error, :can_not_calculate_total_edited}
    end
  end
end
