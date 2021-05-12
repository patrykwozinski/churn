defmodule Churn.Configuration do
  @moduledoc """
  Represents the whole configuration of Churn.
  It's used for every run.
  """

  use TypedStruct

  typedstruct enforce: true do
    field(:min_score_to_show, pos_integer())
    field(:commit_since, String.t())
    field(:directories_to_scan, list(String.t()))
    field(:file_extensions, list(String.t()))
    field(:files_to_ignore, list(String.t()))
  end

  @default_minimum_score_to_show 0.1
  @default_commit_since "1 year ago"
  @default_directories_to_scan ["."]
  @default_file_extensions ["ex"]
  @default_files_to_ignore []

  @spec build(list(any())) :: t()
  def build(args \\ []) when is_list(args) do
    min_score_to_show = Keyword.get(args, :min_score_to_show, @default_minimum_score_to_show)
    commit_since = Keyword.get(args, :commit_since, @default_commit_since)
    directories_to_scan = Keyword.get(args, :directories_to_scan, @default_directories_to_scan)
    file_extensions = Keyword.get(args, :file_extensions, @default_file_extensions)
    files_to_ignore = Keyword.get(args, :files_to_ignore, @default_files_to_ignore)

    %__MODULE__{
      min_score_to_show: min_score_to_show,
      commit_since: commit_since,
      directories_to_scan: directories_to_scan,
      file_extensions: file_extensions,
      files_to_ignore: files_to_ignore
    }
  end
end
