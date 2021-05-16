defmodule Churn.File.Finder do
  @moduledoc false

  alias Churn.File

  @spec find([String.t()], [String.t()], [String.t()]) :: [File.t()]
  def find(paths, extensions, files_to_ignore) do
    extensions = Enum.join(extensions, ",")

    paths
    |> Enum.flat_map(fn path ->
      path
      |> Path.join("**")
      |> Path.join("*.{#{extensions}}")
      |> Path.wildcard()
      |> Enum.uniq()
      |> Enum.reject(&Enum.member?(files_to_ignore, &1))
    end)
    |> Enum.map(&File.build/1)
  end
end
