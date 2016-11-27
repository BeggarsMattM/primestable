defmodule Primes do
  import ExProf.Macro

  def get_first_n_primes(n) when is_integer(n) and n > 0 do
    #profile do
      primes = Enum.take oneill_sieve, n
      IO.inspect primes
    #end  
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

  def different_sieve do
    Stream.unfold(2..100_000, &next_prime/1)
  end
  def next_prime(collection) do
    first = hd(Enum.take collection, 1)
    new_collection = Stream.filter(collection, fn(x) -> rem(x, first) != 0 end)
    {first, new_collection}
  end

  def oneill_sieve do
    Stream.unfold(prelim_state, fn(state) -> {state.current, next(state)} end)
  end  

  def prelim_state do
    %{current: 2, lookups: add_to(Map.new, 2)}
  end

  def next(%{current: current, lookups: lookups}) do
    case lookups[current+1] do 
      nil -> %{ current: current + 1, lookups: add_to(lookups, current+1) }
      stream -> next(%{current: current + 1, lookups: amend_for(lookups, current + 1)}) 
    end
  end

  def add_to(lookups, current) do
    Map.put_new lookups, current * current, Stream.map((current+1)..100_000, &(&1 * current))
  end

  def cascade(map, key) do
      case map[key] do
        nil -> map
        n   -> cascade(map, n |> Enum.take(1) |> hd) |> Map.put_new(n |> Enum.take(1) |> hd, Stream.drop(n, 1)) |> Map.delete(key)
      end
  end  

  def amend_for(lookups, current) do
      {lookup, remaining_map} = Map.pop(lookups, current)
      key = lookup |> Enum.take(1) |> hd
      remaining_map |> cascade(key)
        # case Map.has_key?(remaining_map, key) do
        #   true -> remaining_map |> Map.put_new(remaining_map[key] |> Enum.take(1) |> hd, Stream.drop(remaining_map[key], 1)) |> Map.delete(key)
        #   false -> remaining_map
        # end   
       |> Map.put_new(key, Stream.drop(lookup, 1)) 
  end

end