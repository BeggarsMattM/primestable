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
    assert Regex.match?(~r/\|\s+\|\s+2 \|\n|\s+2 \|\s+4 \|/, primes_table(1)) 
  end

  test "get the example primes table" do
    assert Regex.match?(~r/\|\s+\|\s+2 \|\s+3 \|\s+5 \|\n/, primes_table(3))
  end

  test "columns shouldn't expand get wider as the numbers increase" do
    row_containing_3_digit_prime = 
      primes_table(5) |> String.split("\n")
                      |> List.last
    assert row_containing_3_digit_prime == 
      "|  11 |  22 |  33 |  55 |  77 | 121 |"
  end

  test "we should generate a neat table even if the table is huge" do
    first_row_of_table = primes_table(30) |> String.split("\n") |> hd
    last_row_of_table  = primes_table(30) |> String.split("\n") |> List.last
    assert String.length(first_row_of_table) == String.length(last_row_of_table)
  end

  test "length of square of largest prime when N is 30" do 
    assert largest_length_needed(30) == 5  
  end  
end
