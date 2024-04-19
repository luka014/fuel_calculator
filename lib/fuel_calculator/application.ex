defmodule FuelCalculator.Application do
  @moduledoc false

  use Application

  require Logger

  @impl Application
  def start(type, _args) do
    Logger.info(fn -> "Starting #{inspect(__MODULE__)} in #{inspect(type)} mode. env = #{Mix.env()}" end)
    Logger.info(fn -> "Loaded configs are #{inspect(config())}" end)
    FuelCalculator.Supervisor.start_link()
  end

  defp config, do: Application.fetch_env!(:fuel_calculator, :gravity)
end
