defmodule PrimestableTest do
  use ExUnit.Case
  doctest Primestable

  import Primestable

  test "gets the first prime" do
    assert get_primes(1) == [2]
  end

  test "gets the first two primes" do
    assert get_primes(2) == [2, 3]
  end

  test "gets the first four primes" do
    assert get_primes(4) == [2, 3, 5, 7]
  end    
end
