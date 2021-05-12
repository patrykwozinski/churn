defmodule Churn.File.Finder do
  @moduledoc false

  alias Churn.File

  @spec find([String.t()], [String.t()], [String.t()]) :: [File.t()]
  def find(paths, extensions, _files_to_ignore) do
    extensions = Enum.join(extensions, ",")

    paths
    |> Enum.flat_map(fn path ->
      path
      |> Path.join("**")
      |> Path.join("*.{#{extensions}}")
      |> Path.wildcard()
      |> Enum.uniq()
    end)
    |> Enum.map(fn file_path ->
      File.build(file_path)
    end)
  end
end
