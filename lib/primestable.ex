defmodule Primestable do

  def get_primes(n) do
    Enum.take primes, n
  end

  defp primes do 
    Enum.filter 2..10, &is_prime/1
  end

  defp is_prime(2), do: true
  defp is_prime(n) do 
    # a prime is not divisible by any number between 1 and itself
    Enum.all? 2..n-1, fn(x) -> rem(n, x) != 0 end
  end 

end
