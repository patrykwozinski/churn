defmodule Churn do
  @moduledoc """
  Churn is a good refactoring candidates finder for your version-control system.
  """

  alias Churn.Configuration
  alias Churn.Execution

  def run(args) do
    args
    |> Configuration.build()
    |> Execution.run()
  end
end
