defmodule Primes do
  import ExProf.Macro

  def get_first_n_primes(n) when is_integer(n) and n > 0 do
    profile do
      Enum.take primes, n
      IO.puts "message\n"
    end  
  end
  def get_first_n_primes(_), do: []

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

  def sieved(candidates, primes) do 
    filtered_candidates = for candidate <- candidates, rem(candidate, hd(primes)) != 0, do: candidate
    case filtered_candidates do
      [] -> primes |> Enum.reverse
      _  -> sieved(filtered_candidates, [ (hd(filtered_candidates)) | primes ])
    end    
  end
end