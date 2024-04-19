use Mix.Config

config :fuel_calculator, :gravity,
  earth: 9.807,
  moon: 1.62,
  mars: 3.711

import_config "#{Mix.env()}.exs"
