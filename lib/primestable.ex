defmodule Primestable do

  import Primes

  def primes_table_rec(primes, [], max_length, rows) do
    [ row(primes, 1, max_length, "|" <> pad("", max_length)) | rows ] 
    |> Enum.join("\n")
  end
  def primes_table_rec(primes, [head|tail], max_length, rows) do
    primes_table_rec(primes, tail, max_length, [ row(primes, head, max_length, "|" <> pad(head, max_length)) | rows ])
  end

  def primes_table(n) do
    #header_row(n) <> rows(n)
    primes     = get_first_n_primes(n)
    rev_primes = primes |> Enum.reverse
    max_length = rev_primes |> hd 
                            |> square 
                            |> Integer.to_string
                            |> String.length
    primes_table_rec(primes, rev_primes, max_length, [])
  end

  def square(x), do: x * x

  def row(primes, [], current, max_length, result) do
    result  
  end
  def row(primes, current, max_length, result) do
     add_columns_to_row(primes, primes, current, max_length, result) 
  end

  def add_columns_to_row(_, [], _, _, result) do
    result
  end  
  def add_columns_to_row(primes, [head|tail], current, max_length, result) do
    add_columns_to_row(primes, tail, current, max_length, result <> pad(current * head, max_length))
  end  

  def header_row(n) do
    "|" <> pad("", n) <> header_row_columns(n) <> "\n"
  end

  def header_row_columns(n) do
    get_first_n_primes(n) |> Enum.map(fn (x) -> pad(x, n) end)
                  |> Enum.join
  end  

  def rows(n) do
    Primes.get_first_n_primes(n) |> Enum.map(row_maker(n))
                    |> Enum.join("\n")
  end

  def row_maker(n) do
    fn(x) -> 
      "|" <> pad(x, n)<> row_column_contents(n, x)
    end
  end 

  def row_column_contents(n, x) do
    Primes.get_first_n_primes(n) |> Enum.map(fn (prime) -> pad(prime * x, n) end)
                  |> Enum.join
  end

  def largest_length_needed(n) do
    Primes.get_first_n_primes(n) |> List.last
                  |> (&(&1 * &1)).()
                  |> Integer.to_string
                  |> String.length
  end

  def pad(str, max_length) when max_length < 3 do
    String.pad_leading("#{str} |", 5)
  end  
  def pad(str, max_length) do
    String.pad_leading("#{str} |", max_length + 3)
  end

  def main(args) do
    args |> process
  end
  
  def process([]) do 
    IO.puts "Please enter numeric input N (for N prime numbers)"
  end
  def process(n) do
    IO.puts n
    # IO.puts primes_table(n)
  end    

end
