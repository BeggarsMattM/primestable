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
  
  test "gets the first twenty primes" do 
    assert get_primes(20) == 
      [ 2,  3,  5,  7, 11, 
       13, 17, 19, 23, 29,
       31, 37, 41, 43, 47,
       53, 59, 61, 67, 71]
  end

  test "get_primes behaves correctly for silly inputs" do 
    assert get_primes(0) == []
    assert get_primes(-76) == []
    assert get_primes("sandwich") == []
  end

  test "get the simplest primes table" do 
    assert primes_table(1) ==
      "|    |   2 |\n|   2 |   4|\n"
  end
end
