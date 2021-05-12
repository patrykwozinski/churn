defmodule Churn.Processor.Result do
  @moduledoc false

  use TypedStruct

  alias Churn.File

  typedstruct enforce: true do
    field(:file, File.t())
    field(:complexity, pos_integer())
    field(:times_changed, pos_integer())
    field(:score, float() | :not_calculated)
  end

  @spec build(File.t(), pos_integer(), pos_integer()) :: t()
  def build(file, complexity, times_changed) do
    %__MODULE__{
      file: file,
      complexity: complexity,
      times_changed: times_changed,
      score: :not_calculated
    }
  end

  @spec get_priority(t()) :: pos_integer()
  def get_priority(%__MODULE__{complexity: complexity, times_changed: times_changed}),
    do: complexity * times_changed

  @spec with_score(t(), pos_integer(), pos_integer()) :: t()
  def with_score(result, max_times_changed, max_complexity) do
    # Calculate the horizontal and vertical distance from the "top right" corner.
    horizontal_distance = max_times_changed - result.times_changed
    vertical_distance = max_complexity - result.complexity

    # Normalize these values over time, we first divide by the maximum values,
    # to always end up with distances between 0 and 1.
    normalized_horizontal_distance = horizontal_distance / max_times_changed
    normalized_vertical_distance = vertical_distance / max_complexity

    # Calculate the distance of this class from the "top right" corner,
    # using the simple formula A^2 + B^2 = C^2; or: C = sqrt(A^2 + B^2)).
    distance_from_top_right_corner =
      :math.sqrt(
        :math.pow(normalized_horizontal_distance, 2) + :math.pow(normalized_vertical_distance, 2)
      )

    # The resulting value will be between 0 and sqrt(2). A short distance is bad,
    # so in order to end up with a high score, we invert the value by
    # subtracting it from 1.
    score = Float.round(1 - distance_from_top_right_corner, 3)

    %__MODULE__{result | score: score}
  end
end
