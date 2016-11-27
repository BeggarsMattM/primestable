defmodule Primes do
  @moduledoc """
  The Primes module generates a list of the first n prime numbers
  using the Sieve of Eratosthenes.
  """

  @doc """
  Given numeric input N, returns a list of N primes. 

  ## Example (N = 10)

  [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  """
  def get_first_n_primes(n) when is_integer(n) and n > 0 do
      Enum.take sieve, n
  end
  def get_first_n_primes(_), do: []

  defp sieve do
    Stream.unfold(start_state, fn(state) -> {state.current, step(state)} end)
  end  

  # The first prime is 2 and we create our first entry in the lookup table
  # based on this, so that when we reach the next multiple of 2 (i.e. 4) it
  # can be recognised as non-prime. 
  defp start_state do
    %{current: 2, lookups: add(Map.new, 2)}
  end

  # We look up the next consective integer in our lookup table. If we cannot
  # find it we have a prime and so add a new entry to the table to flag up
  # multiples of this new prime, then return the new state to the stream.
  # If we find it, it's a non-prime and we must appropriately amend the lookup
  # table before trying the next consecutive integer. 
  defp step(%{current: current, lookups: lookups}) do
    next = current + 1
    case lookups[next] do 
      nil -> %{ current: next, lookups: add( lookups, next ) }
      _   -> step(%{ current: next, lookups: amend( lookups, next ) }) 
    end
  end

  # To add an entry to the lookup table for a prime we use its square for a key,
  # and a tuple that "remembers" what prime we are eliminating multiples of, and
  # what the following multiple in our "stream" is going to be. e.g.
  # 2 -> 4 : { 2, 6 }
  # 3 -> 9 : { 3, 12 }
  # 13 -> 169 : { 13, 182 }
  defp add(lookups, current) do
    Map.put_new lookups, current * current, {current, current * current + current}
  end

  # To amend an existing entry in the lookup table, we can use the stored next 
  # value as a new key, and increment it by the prime of which these values 
  # are multiples to find the next value in the stream. e.g.
  # 4 : { 2, 6 } -> 6 : { 2, 8 }
  # 9 : { 3, 12 } -> 12 : { 3, 15 }
  # 169 : { 13, 182 } -> 182 : { 13, 195 }
  # The new key may already exist as multiplier of a different prime! As such
  # we must pass the value to a function that checks we don't overwrite anything. 
  defp amend(lookups, current) do
      {{multiple_of, next_value}, remaining_map} = Map.pop(lookups, current)
      remaining_map |> cascade(next_value)
                    |> Map.delete(next_value) 
                    |> Map.put_new(next_value, {multiple_of, next_value + multiple_of}) 
  end

  # If we are about to delete and readd a key we want to check it doesn't already
  # exist. If it doesn't we're fine and can take no action. If it does exist, we 
  # need to update that key before it gets overwritten. This function must recurse
  # "up the chain" until it knows that nothing will be overwritten at any point. 
  defp cascade(map, key) do
      case map[key] do
        nil -> map
        {multiple_of, key} -> 
          cascade(map, key) |> Map.delete(key) 
                            |> Map.put_new(key, {multiple_of, key + multiple_of})
      end
  end  

end