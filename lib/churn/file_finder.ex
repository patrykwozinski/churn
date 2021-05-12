defmodule Churn.FileFinder do
  @moduledoc false

  @spec find([String.t()], [String.t()], [String.t()]) :: [String.t()]
  def find(paths, extensions, _files_to_ignore) do
    extensions = Enum.join(extensions, ",")

    paths
    |> Enum.flat_map(fn path ->
      path
      |> Path.join("**")
      |> Path.join("*.{#{extensions}}")
      |> Path.wildcard()
    end)
  end
end
