defmodule FuelCalculatorTest do
  use ExUnit.Case, async: true

  alias FuelCalculator
  alias FuelCalculator.TestHelper

  require Logger

  describe "FuelCalculator.calculate/2" do
    setup do
      happy_path = TestHelper.happy_path_params()

      [happy_path: happy_path]
    end

    test "stress test", %{happy_path: happy_path} do
      0..100_000
      |> Enum.map(fn i ->
        Task.async(fn ->
          %{input: {paths, mass}, expected_output: expected_output} =
            happy_path |> Enum.at(Integer.mod(i, length(happy_path)))

          Logger.debug(fn -> "Starting a new test process with pid: #{inspect(self())}" end)

          {FuelCalculator.calculate(mass, paths), expected_output}
        end)
      end)
      |> Enum.map(&Task.await/1)
      |> Enum.each(fn {result, expected_output} ->
        assert result == expected_output
      end)
    end
  end
end
