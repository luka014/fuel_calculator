defmodule FuelCalculator.Calculator do
  @moduledoc false

  def calculate_paths(paths, mass) when is_list(paths) do
    paths
    |> Enum.reverse()
    |> Enum.reduce(mass, fn path, total_mass ->
      fuel = calculate_path(path, total_mass)
      total_mass + fuel
    end)
    |> Kernel.-(mass)
  end

  defp calculate_path({action, planet}, mass) do
    calculate_fuel(action, mass, get_gravity(planet))
  end

  defp calculate_fuel(:launch, mass, _gravity) when mass <= 0, do: 0

  defp calculate_fuel(:launch, mass, gravity) do
    with fuel <- [Float.floor(mass * gravity * 0.042 - 33), 0] |> Enum.max(),
         fuel_for_fuel <- calculate_fuel(:launch, fuel, gravity) do
      fuel + fuel_for_fuel
    end
  end

  defp calculate_fuel(:land, mass, _gravity) when mass <= 0, do: 0

  defp calculate_fuel(:land, mass, gravity) do
    with fuel <- [Float.floor(mass * gravity * 0.033 - 42), 0] |> Enum.max(),
         fuel_for_fuel <- calculate_fuel(:land, fuel, gravity) do
      fuel + fuel_for_fuel
    end
  end

  defp get_gravity(planet), do: Application.fetch_env!(:fuel_calculator, :gravity)[String.to_atom(planet)]
end
