defmodule ChurnTest do
  use ExUnit.Case
  doctest Churn

  test "greets the world" do
    assert Churn.hello() == :world
  end
end
