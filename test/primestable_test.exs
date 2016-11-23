defmodule PrimestableTest do
  use ExUnit.Case
  doctest Primestable

  test "gets the first prime" do
    assert get_primes(1) == [2]
  end  
end
