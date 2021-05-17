defmodule Churn.Processor.ResultTest do
  use ExUnit.Case, async: true

  alias Churn.File
  alias Churn.Processor.Result

  test "it successfully builds struct" do
    # [Given] any file, complexity lvl 3 and 3 times edited info
    file = File.build("lib/churn.ex")
    complexity = 3
    times_changed = 3

    # [When] building result
    result = Result.build(file, complexity, times_changed)

    # [Then] result score is not calculated
    assert result.score == :not_calculated
    # [And Then] priority equals complexity times frequency of changing
    assert result |> Result.get_priority() == 9
  end

  test "it calculates score of result with max metrics" do
    # [Given] any result with complexity lvl 3 and 3 times edited
    file = File.build("lib/churn.ex")
    complexity = 3
    times_changed = 3
    result = Result.build(file, complexity, times_changed)
    # [And Given] maximum times changed 3 and maximum complexity 3
    max_times_changed = 3
    max_complexity = 3

    # [When] calculating score
    result_with_score =
      Result.with_score(
        result,
        max_times_changed,
        max_complexity
      )

    # [Then] score equals normalized distance from "top right" corner
    assert result_with_score.score == 1.0
  end
end
