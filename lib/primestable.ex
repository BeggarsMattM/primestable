defmodule Primestable do
  @moduledoc """
  The Primestable module outputs a multiplication table of prime numbers.
  """
  import Primes

  @doc """
  Given numeric input N, outputs a table of N prime numbers. 

  ## Example (N = 3)

  |      |    2 |    3 |    5 |
  |    2 |    4 |    6 |   10 |
  |    3 |    6 |    9 |   15 |
  |    5 |   10 |   15 |   25 |
  """
  def primes_table(n) do
    primes         = get_first_n_primes(n)
    primes_desc    = primes |> Enum.reverse
    
    # To ensure that all the cells are of equal width we need to know how
    # large the largest value we need to contain is. This will be the length
    # of the square of the largest prime. 
    max_width  = primes_desc |> hd 
                             |> square 
                             |> Integer.to_string
                             |> String.length
    
    primes_table_rec(primes, primes_desc, max_width, [])
  end

  defp square(n), do: n * n

  # A recursive generator of our table. While the second argument is a list of
  # primes we take the head and use it to generate a row which is added to the 
  # front of our rows collection. Once we run out of primes we add a header 
  # row and join together our list with newline characters.
  defp primes_table_rec(primes, [current_prime|remaining_primes], max_width, rows) do
    new_row = row(primes, current_prime, max_width, first_col(current_prime, max_width))
    primes_table_rec(primes, remaining_primes, max_width, [ new_row | rows ])
  end
  defp primes_table_rec(primes, [], max_width, rows) do
    [ header_row(primes, max_width) | rows ] 
    |> Enum.join("\n")
  end

  # The first column has a starting "border" character and is a value (or 
  # no value) padded to a width dependent on the max_width we calculated. 
  defp first_col(value, max_width) do
    "|" <> pad(value, max_width)
  end  

  # We will generate a row as we generate the table, by recursively adding
  # columns until there is nothing left to do.
  def row(primes, current, max_length, result) do
     add_columns_to_row(primes, primes, current, max_length, result) 
  end
 
  # Keep concatenating columns to the result until no primes remaining,
  # then return result. 
  def add_columns_to_row(primes, [current_prime|remaining_primes], row_multiplier, max_width, result) do
    next_col = pad(row_multiplier * current_prime, max_width)
    add_columns_to_row(primes, remaining_primes, row_multiplier, max_width, result <> next_col)
  end
  def add_columns_to_row(_, [], _, _, result) do
    result
  end   

  # The header row works like other rows, except the first column is empty
  # and the multiplier for primes in successive columns is 1 (i.e identity)
  def header_row(primes, max_length) do
    row(primes, 1, max_length, first_col("", max_length))
  end  

  # We leading_pad all the columns according to the max_width we calculated 
  def pad(str, max_width) do
    String.pad_leading("#{str} |", max_width + 3)
  end

  def main(args) do
    args |> process
  end
  
  def process([]) do 
    IO.puts "Please enter numeric input N (for N prime numbers)"
  end
  def process([n]) do
    IO.puts primes_table(n |> String.to_integer)
  end    

end
