defmodule FuelCalculator.Helper do
  @moduledoc false

  def normalize_input(paths) do
    paths
    |> Enum.map(fn {action, planet} -> {action, String.downcase(planet)} end)
  end
end
