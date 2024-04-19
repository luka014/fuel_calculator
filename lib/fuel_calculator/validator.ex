defmodule FuelCalculator.Validator do
  @moduledoc false

  require Integer

  @actions ~w(
    launch
    land
  )a

  @planets ~w(
    earth
    moon
    mars
  )

  def validate(paths) do
    with :ok <- validate_actions(paths),
         :ok <- validate_planets(paths),
         :ok <- validate_pairs(paths) do
      :ok
    end
  end

  defp validate_actions(paths) do
    paths
    |> Enum.map(fn {action, _} -> action end)
    |> Enum.all?(&Enum.member?(@actions, &1))
    |> case do
      true -> :ok
      false -> {:error, "Invalid action supplied. Valid values are [:land, :launch]"}
    end
  end

  defp validate_planets(paths) do
    paths
    |> Enum.map(fn {_, planet} -> planet end)
    |> Enum.all?(&Enum.member?(@planets, &1))
    |> case do
      true -> :ok
      false -> {:error, "Unknown gravity for supplied planet."}
    end
  end

  defp validate_pairs(paths) when Integer.is_even(length(paths)) do
    length = length(paths)

    0..(length - 1)
    |> Enum.take_every(2)
    |> Enum.reduce_while("earth", fn i, valid_planet_source ->
      {action1, planet1} = Enum.at(paths, i)
      {action2, planet2} = Enum.at(paths, i + 1)

      if action1 == :launch and action2 == :land and planet1 == valid_planet_source do
        {:cont, planet2}
      else
        {:halt, :error}
      end
    end)
    |> case do
      :error -> {:error, "Invalid path provided."}
      _ -> :ok
    end
  end

  defp validate_pairs(_), do: {:error, "Invalid path provided."}
end
