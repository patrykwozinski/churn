defmodule ChurnTest do
  use ExUnit.Case

  test "it works" do
    assert Churn.run([]) == :ok
  end
end
