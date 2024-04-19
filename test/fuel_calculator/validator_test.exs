defmodule FuelCalculator.ValidatorTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias FuelCalculator.Validator

  describe "Validator.validate/1" do
    test "Returns error for invalid action" do
      assert {:error, "Invalid action supplied. Valid values are [:land, :launch]"} ==
               Validator.validate([{:invalid_action, "mars"}])
    end

    test "Returns error for invalid planet" do
      assert {:error, "Unknown gravity for supplied planet."} == Validator.validate([{:launch, "uranus"}])
    end

    test "Returns error if the starting planet is not earth" do
      assert {:error, "Invalid path provided."} == Validator.validate([{:launch, "mars"}, {:land, "mars"}])
    end

    test "Returns error if supplied path has odd number of elements" do
      assert {:error, "Invalid path provided."} ==
               Validator.validate([{:launch, "earth"}, {:land, "mars"}, {:launch, "earth"}])
    end

    test "Returns error if the actions order is incorrect" do
      assert {:error, "Invalid path provided."} == Validator.validate([{:land, "earth"}, {:launch, "earth"}])
      assert {:error, "Invalid path provided."} == Validator.validate([{:land, "earth"}, {:land, "earth"}])
      assert {:error, "Invalid path provided."} == Validator.validate([{:launch, "earth"}, {:launch, "earth"}])

      assert {:error, "Invalid path provided."} ==
               Validator.validate([{:launch, "earth"}, {:land, "earth"}, {:land, "mars"}, {:launch, "mars"}])
    end

    test "Returns error if launching from a planet you did not first land to" do
      assert {:error, "Invalid path provided."} ==
               Validator.validate([{:launch, "earth"}, {:land, "mars"}, {:launch, "moon"}, {:land, "earth"}])
    end

    test "Returns :ok for correct path" do
      assert :ok ==
               Validator.validate([
                 {:launch, "earth"},
                 {:land, "mars"},
                 {:launch, "mars"},
                 {:land, "moon"},
                 {:launch, "moon"},
                 {:land, "earth"}
               ])
    end
  end
end
