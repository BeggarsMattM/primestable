defmodule Primestable do

  def get_primes(n) do
    Enum.map 1..n, fn(x) -> x + 1 end
  end  

end
