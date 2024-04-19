defmodule FuelCalculator.Server.State do
  @moduledoc false

  @fields ~w(
    ship_weight
    fuel_weight
  )a

  defp fields, do: @fields

  defstruct ship_weight: 0,
            fuel_weight: 0

  def new(%{} = attrs) do
    struct!(__MODULE__, attrs)
  end

  def new do
    struct!(__MODULE__)
  end

  def update(%__MODULE__{} = state, %{} = attrs) do
    state
    |> struct!(Map.take(attrs, fields()))
  end
end
