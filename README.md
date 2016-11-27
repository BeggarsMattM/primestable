
A test-driven Elixir application outputting a multiplication table of prime numbers.

Can be run from the command line:

$ ./primestable 3
|     |   2 |   3 |   5 |   7 |  11 |
|   2 |   4 |   6 |  10 |  14 |  22 |
|   3 |   6 |   9 |  15 |  21 |  33 |
|   5 |  10 |  15 |  25 |  35 |  55 |
|   7 |  14 |  21 |  35 |  49 |  77 |
|  11 |  22 |  33 |  55 |  77 | 121 |

Or from within iex after running `iex -S mix`:

iex(1)> IO.puts Primestable.primes_table 4
|    |  2 |  3 |  5 |  7 |
|  2 |  4 |  6 | 10 | 14 |
|  3 |  6 |  9 | 15 | 21 |
|  5 | 10 | 15 | 25 | 35 |
|  7 | 14 | 21 | 35 | 49 |
:ok

I was happy to be able to steadily whittle this down from some fairly
overblown initial "ideas". I was delighted to learn more about approaches
to the Sieve of Eratosthenes from Melissa O'Neill's apparently famous
paper and there are definitely still more optimisations that could
be made if efficient generation of primes is a priority. I feel like the
first several thousand primes are enough for the purposes of viewing a 
multiplication table on the command line. If table generation speed was our
primary purpose we could always hardcode a lot of primes instead of generating
them all every time.

Given more time I would like to improve the table generation speed. It 
suddenly feels as if there must be a better way of populating the table
given that it the NE and SW are mirror images of each other.

I found a test-driven approach a little difficult due to inexperience of
TDD in functional environments and specifically Elixir: for instance I wasn't
at all sure whether private methods could or should be tested. I felt that knowing
what sort of tests provide the biggest bang for their buck is probably the
kind of thing that comes with practice. But I certainly enjoyed trying to
write tests in advance of code here and the safety net of being able to run
the tests again later.


