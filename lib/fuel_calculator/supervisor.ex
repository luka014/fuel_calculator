defmodule FuelCalculator.Supervisor do
  @moduledoc """
  A simple Supervisor for the FuelCalculator.Server
  The strategy :one_for_one defines that if any pocess dies the supervisor will restart just that process
    and not interfere with the others.
  It will attempt to restart the GenServer maximum 3 times and no longer than 5 seconds.
  """

  def start_link do
    children = [
      FuelCalculator.Server
    ]

    Supervisor.start_link(
      children,
      strategy: :one_for_one,
      max_restarts: 3,
      max_seconds: 5
    )
  end
end
