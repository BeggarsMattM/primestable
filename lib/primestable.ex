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
    primes = get_first_n_primes(n)
    
    # To ensure that all the cells are of equal width we need to know how
    # large the largest value we need to contain is. This will be the length
    # of the square of the largest prime. 
    max_width  = primes |> List.last 
                        |> square 
                        |> Integer.to_string
                        |> String.length
    
    [ 1 | primes ] |> Enum.map(&(row(primes, &1, max_width)))
                   |> Enum.join("\n")
  end

  defp square(n), do: n * n

  # The first column has a starting "border" character and is a value (or 
  # no value) padded to a width dependent on the max_width we calculated. 
  defp first_col(value, max_width) do
    "|" <> pad(value, max_width)
  end  

  # We will generate a row as we generate the table, by recursively adding
  # columns until there is nothing left to do.
  def row(primes, 1, max_width) do
      col_1 = first_col("", max_width)
      cols  = primes |> Enum.map(&(pad(&1, max_width)))

      [ col_1 | cols ] |> Enum.join
  end
  def row(primes, n, max_width) do
      col_1 = first_col(n, max_width)
      cols  = primes |> Enum.map(&(pad(&1 * n, max_width)))
     
      [col_1 | cols] |> Enum.join
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
