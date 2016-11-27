defmodule Primes2 do
  # Basic implementation of an infinite prime generator, as explained at
    # http://www.cs.hmc.edu/~oneill/papers/Sieve-JFP.pdf

      def new do
          %{composites: HashDict.new, current: 2}
	    end

	      def next(%{composites: composites, current: current} = sieve) do
	          case HashDict.get(composites, current) do
		        nil ->
			        sieve
				        |> add_composite(current * current, current)
					        |> advance

						      factors ->
						              Enum.reduce(factors, sieve, &add_composite(&2, current + &1, &1))
							              |> remove_current
								              |> advance
									              |> next
										          end
											    end

											      defp advance(%{current: current} = sieve) do
											          %{sieve | current: current + 1}
												    end

												      defp remove_current(%{composites: composites, current: current} = sieve) do
												          %{sieve | composites: HashDict.delete(composites, current)}
													    end

													      defp add_composite(%{composites: composites} = sieve, which, factor) do
													          %{sieve | composites: HashDict.update(composites, which, [factor], &[factor | &1])}
														    end

														      def stream do
														          Stream.unfold(new, fn(acc) -> {acc.current, next(acc)} end)
															    end

															      def nth(n) do
															          stream
																      |> Stream.drop(n -  1)
																          |> Enum.take(1)
																	      |> hd
																	        end
																		end
