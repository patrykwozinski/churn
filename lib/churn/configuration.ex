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

  @spec build() :: t()
  def build(args \\ []) when is_list(args) do
    min_score_to_show = Keyword.fetch!(args, :min_score_to_show)
    commit_since = Keyword.fetch!(args, :commit_since)
    directories_to_scan = Keyword.fetch!(args, :directories_to_scan)
    file_extensions = Keyword.fetch!(args, :file_extensions)
    files_to_ignore = Keyword.fetch!(args, :files_to_ignore)

    %__MODULE__{
      min_score_to_show: min_score_to_show,
      commit_since: commit_since,
      directories_to_scan: directories_to_scan,
      file_extensions: file_extensions,
      files_to_ignore: files_to_ignore
    }
  end
end
