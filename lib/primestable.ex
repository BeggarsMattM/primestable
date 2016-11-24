defmodule Primestable do

  def get_primes(n) when is_integer(n) and n > 0 do
    Enum.take primes, n
  end
  def get_primes(_), do: []

  defp primes do 
    Stream.filter 2..100_000_000, &is_prime/1
  end

  defp is_prime(n) when n < 2 do
    raise "tried to check primality of number less then 2"
  end  
  defp is_prime(2), do: true
  defp is_prime(n) do 
    # a prime is not divisible by any number between 1 and itself
    Enum.all? 2..n-1, fn(x) -> rem(n, x) != 0 end
  end

  def primes_table(n) do
    header_row(n) <> rows(n)
  end

  def header_row(n) do
    "|" <> pad("", n) <> header_row_columns(n) <> "\n"
  end

  def header_row_columns(n) do
    get_primes(n) |> Enum.map(fn (x) -> pad(x, n) end)
                  |> Enum.join
  end  

  def rows(n) do
      get_primes(n) |> Enum.map(row_maker(n))
                    |> Enum.join("\n")
  end

  def row_maker(n) do
    fn(x) -> 
      "|" <> pad(x, n)<> row_column_contents(n, x)
    end
  end 

  def row_column_contents(n, x) do
    get_primes(n) |> Enum.map(fn (prime) -> pad(prime * x, n) end)
                  |> Enum.join
  end

  def largest_length_needed(n) do
    get_primes(n) |> List.last
                  |> (&(&1 * &1)).()
                  |> Integer.to_string
                  |> String.length
  end

  def pad(str, n) when n < 3 do
    String.pad_leading("#{str} |", 5)
  end  
  def pad(str, n) do
    max_length = largest_length_needed(n)
    String.pad_leading("#{str} |", max_length + 3)
  end

  def main(args) do
    args |> process
  end
  
  def process([]) do 
    IO.puts "Please enter numeric input N (for N prime numbers)"
  end
  def process(n) do
    IO.puts primes_table(n)
  end    

end
