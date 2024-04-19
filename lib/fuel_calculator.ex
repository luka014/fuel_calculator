defmodule FuelCalculator do
  @moduledoc false

  alias FuelCalculator.Helper
  alias FuelCalculator.Server
  alias FuelCalculator.Validator

  @spec calculate(Integer.t(), list(tuple())) :: Integer.t()
  def calculate(ship_weight, paths) do
    with paths <- Helper.normalize_input(paths),
         :ok <- Validator.validate(paths) do
      Server.calculate(ship_weight, paths)
    end
  end
end
