<h1 align="center">Fuel Calculator</h1>

Simple application that calculates the amount of fuel needed for the spaceship to complete its journey.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Install](#install)
- [Start](#start)
- [Inputs](#insputs)
- [Tests](#tests)
- [Configuration](#configuration)


### Prerequisites
* [asdf](https://github.com/asdf-vm/asdf)
* Installed _elixir_ and _erlang_ `asdf` plugins:
  ```sh
  $ asdf plugin-add erlang
  $ asdf plugin-add elixir
  ```

### Install
```sh
$ git clone https://github.com/luka014/fuel_calculator && cd fuel_calculator
$ asdf install
$ mix deps.get
```

### Start
```sh
$ iex -S mix
```

### Inputs
The FuelCalculator.calculate/2 receives a flight route as 2 arguments.
The first one is the flight ship mass, and the second is an array of 2 element tuples,
 with the first element being land or launch directive as atoms (:launch, :land), and the second element is the target planet gravity as string.


## Tests
```sh
$ mix test
```


## Configuration
All configuration is consolidated in `config/config.exs` and environment
specific files (`dev.exs`, `test.exs`) which override the defaults
with environment specific differences. It is a standard _Elixir_
project setup.
Planet gravities are handled through these configuration files.
