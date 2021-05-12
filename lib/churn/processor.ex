defmodule Churn.Processor do
  @moduledoc false

  alias Churn.File

  @type success_response :: %{
          required(:complexity, pos_integer()),
          required(:times_changed, non_neg_integer())
        }

  @spec process(File.t()) :: {:ok, success_response()}
  def process(%File{} = file) do
  end
end
