defmodule FuelCalculator.TestHelper do
  @moduledoc false

  def happy_path_params do
    [
      %{
        input: {[{:launch, "earth"}, {:land, "moon"}, {:launch, "moon"}, {:land, "earth"}], 28_801},
        expected_output: 51_898
      },
      %{
        input: {[{:launch, "earth"}, {:land, "mars"}, {:launch, "mars"}, {:land, "earth"}], 14_606},
        expected_output: 33_388
      },
      %{
        input:
          {[
             {:launch, "earth"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "earth"}
           ], 75_432},
        expected_output: 212_161
      },
      %{
        input:
          {[
             {:launch, "earth"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "earth"}
           ], 97_531},
        expected_output: 1_232_894
      }
    ]
  end
end
