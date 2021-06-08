defmodule Churn.CLI do
  @moduledoc """
  `Churn.CLI` is the entrypoint for both the Mix task and the escript.
  """

  @strict_requirements [
    min_score_to_show: :float,
    commit_since: :string,
    directories_to_scan: :string,
    file_extensions: :string,
    files_to_ignore: :string,
    config: :string
  ]

  @aliases [
    s: :min_score_to_show,
    t: :commit_since,
    d: :directories_to_scan,
    e: :file_extensions,
    i: :files_to_ignore,
    c: :config
  ]

  @doc """
  Runs Churn with the given `args` and exits the process.
  """
  def main(args \\ []) do
    {valid_arguments, _, _} =
      OptionParser.parse(args, aliases: @aliases, strict: @strict_requirements)

    valid_arguments
    |> Enum.map(fn
      {:directories_to_scan, dirs} -> {:directories_to_scan, String.split(dirs, ",")}
      {:file_extensions, exts} -> {:file_extensions, String.split(exts, ",")}
      {:files_to_ignore, ignores} -> {:files_to_ignore, String.split(ignores, ",")}
      arg -> arg
    end)
    |> Churn.run()
  end
end
