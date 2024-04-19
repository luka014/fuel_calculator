defmodule FuelCalculator.Server do
  @moduledoc false

  use GenServer

  alias FuelCalculator.Calculator
  alias FuelCalculator.Server.State

  @timeout 2_000

  def start_link(args), do: GenServer.start_link(__MODULE__, args, name: __MODULE__)

  def calculate(ship_weight, paths), do: call_server({:calculate, ship_weight, paths})

  def get_fuel_weight, do: call_server(:get_fuel_weight)

  @impl GenServer
  def init(_) do
    {:ok, State.new()}
  end

  @impl GenServer
  def handle_call({:calculate, ship_weight, paths}, _from, %State{} = state) do
    fuel = Calculator.calculate_paths(paths, ship_weight)
    new_state = state |> State.update(%{ship_weight: ship_weight, fuel_weight: fuel})
    {:reply, trunc(new_state.fuel_weight), new_state}
  end

  @impl GenServer
  def handle_call(:get_fuel_weight, _from, %State{} = state) do
    {:reply, trunc(state.fuel_weight), state}
  end

  defp server_pid, do: GenServer.whereis(__MODULE__)

  defp call_server(request) do
    GenServer.call(server_pid(), request, @timeout)
  catch
    :exit, {:normal, _} -> {:error, :not_found}
  end
end
