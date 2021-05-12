defmodule Churn.Execution do
  @moduledoc """
  The main mechanism responsible for running analyse of printing results on the screen.
  """

  alias Churn.Configuration

  @spec run(Configuration.t()) :: :ok
  def run(%Configuration{}) do
    :ok
  end
end
