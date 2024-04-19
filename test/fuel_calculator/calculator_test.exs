defmodule FuelCalculator.CalculatorTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias FuelCalculator.Calculator
  alias FuelCalculator.TestHelper

  describe "Calculator.calculate_paths/2" do
    test "Happy path tests" do
      TestHelper.happy_path_params()
      |> Enum.each(fn %{input: {paths, mass}, expected_output: expected_output} ->
        assert expected_output == Calculator.calculate_paths(paths, mass)
      end)
    end
  end
end
