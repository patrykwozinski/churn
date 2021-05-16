defmodule Churn.Configuration do
  @moduledoc """
  Represents the whole configuration of Churn.
  It's used for every run.
  """

  @default_config_file ".churn.exs"

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
    config =
      args
      |> Keyword.get(:config, @default_config_file)
      |> load_default_config()

    min_score_to_show = fetch(args, :min_score_to_show, config)
    commit_since = fetch(args, :commit_since, config)
    output_type = fetch(args, :output_type, config)
    directories_to_scan = fetch(args, :directories_to_scan, config)
    file_extensions = fetch(args, :file_extensions, config)
    files_to_ignore = fetch(args, :files_to_ignore, config)

    %__MODULE__{
      min_score_to_show: min_score_to_show,
      commit_since: commit_since,
      output_type: output_type,
      directories_to_scan: directories_to_scan,
      file_extensions: file_extensions,
      files_to_ignore: files_to_ignore
    }
  end

  defp load_default_config(config_file) do
    unless File.exists?(config_file), do: raise("config file don't exist")

    {configuration, _} = Code.eval_file(config_file)

    Map.to_list(configuration)
  end

  defp fetch(args, key, defaults) do
    default_value = Keyword.fetch!(defaults, key)

    Keyword.get(args, key, default_value)
  end
end
