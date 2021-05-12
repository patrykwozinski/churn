defmodule Churn.Configuration do
  @moduledoc """
  Represents the whole configuration of Churn.
  It's used for every run.
  """

  use TypedStruct

  typedstruct enforce: true do
    field(:args, list(any()))
    field(:min_score_to_show, pos_integer())
    field(:commit_since, String.t())
    field(:directories_to_scan, list(String.t()))
    field(:file_extensions, list(String.t()))
    field(:files_to_ignore, list(String.t()))
  end

  @spec build() :: %__MODULE__.t()
  def build(args \\ []) when is_list(args) do

  end
end
