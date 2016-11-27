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
  def row(primes, current, max_width, first_col) do
     [ first_col | Enum.map(primes, &(pad(&1 * current, max_width))) ]
        |> Enum.join
  end

  # The header row works like other rows, except the first column is empty
  # and the multiplier for primes in successive columns is 1 (i.e identity)
  def header_row(primes, max_width) do
    row(primes, 1, max_width, first_col("", max_width))
  end  

  # We leading_pad all the columns according to the max_width we calculated 
  def pad(str, max_width) do
    String.pad_leading("#{str} |", max_width + 3)
  end

  def main(args) do
    args |> process
  end
  
  def process([n]) do
    IO.puts primes_table(n |> String.to_integer)
  end
  def process(_) do 
    IO.puts "Please enter single numeric input N (for N prime numbers)"
  end

end
