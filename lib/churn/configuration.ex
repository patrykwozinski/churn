defmodule Churn.Configuration do
  @moduledoc """
  Represents the whole configuration of Churn.
  It's used for every run.
  """

  @config_file ".churn.exs"

  use TypedStruct

  typedstruct enforce: true do
    field(:min_score_to_show, pos_integer())
    field(:commit_since, String.t())
    field(:output_type, :console)
    field(:directories_to_scan, [String.t()])
    field(:file_extensions, [String.t()])
    field(:files_to_ignore, [String.t()])
  end

  @spec build([any()]) :: t()
  def build(args \\ []) when is_list(args) do
    default_config = load_default_config()

    min_score_to_show = fetch(args, :min_score_to_show, default_config)
    commit_since = fetch(args, :commit_since, default_config)
    output_type = fetch(args, :output_type, default_config)
    directories_to_scan = fetch(args, :directories_to_scan, default_config)
    file_extensions = fetch(args, :file_extensions, default_config)
    files_to_ignore = fetch(args, :files_to_ignore, default_config)

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
    {configuration, _} = Code.eval_file(@config_file)

    Map.to_list(configuration)
  end

  defp fetch(args, key, defaults) do
    default_value = Keyword.fetch!(defaults, key)

    Keyword.get(args, key, default_value)
  end
end
