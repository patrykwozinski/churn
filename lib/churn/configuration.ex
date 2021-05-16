defmodule Churn.Configuration do
  @moduledoc """
  Represents the whole configuration of Churn.
  It's used for every run.
  """

  use TypedStruct

  typedstruct enforce: true do
    field(:min_score_to_show, pos_integer())
    field(:commit_since, String.t())
    field(:output_type, :console)
    field(:directories_to_scan, [String.t()])
    field(:file_extensions, [String.t()])
    field(:files_to_ignore, [String.t()])
  end

  @default_minimum_score_to_show 0.1
  @default_commit_since "1 year ago"
  @default_output_type :console
  @default_directories_to_scan ["lib"]
  @default_file_extensions ["ex"]
  @default_files_to_ignore []

  @spec build([any()]) :: t()
  def build(args \\ []) when is_list(args) do
    _default_config = load_default_config()

    min_score_to_show = Keyword.get(args, :min_score_to_show, @default_minimum_score_to_show)
    commit_since = Keyword.get(args, :commit_since, @default_commit_since)
    output_type = Keyword.get(args, :output_type, @default_output_type)
    directories_to_scan = Keyword.get(args, :directories_to_scan, @default_directories_to_scan)
    file_extensions = Keyword.get(args, :file_extensions, @default_file_extensions)
    files_to_ignore = Keyword.get(args, :files_to_ignore, @default_files_to_ignore)

    %__MODULE__{
      min_score_to_show: min_score_to_show,
      commit_since: commit_since,
      output_type: output_type,
      directories_to_scan: directories_to_scan,
      file_extensions: file_extensions,
      files_to_ignore: files_to_ignore
    }
  end

  defp load_default_config do
    File.read!(".churn.exs") |> Code.require_file() |> IO.inspect()
  end
end
