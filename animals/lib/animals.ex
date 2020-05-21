defmodule Animals do
  @moduledoc """
  Documentation for Animals.
  """

  @doc """
  randomise takes a list of zoo animals and returns a new randomised list with
  the same elements as the first.

  ## Examples

      iex> zoo = Animals.create_zoo
      iex> Animals.randomise(zoo)
      ["monkey", "tiger", "elephant", "gorilla", "giraffe", "lion"]

  """
  def create_zoo do
    ["lion", "tiger", "gorilla", "elephant", "monkey", "giraffe"]
  end

  def randomise(zoo) do
    Enum.shuffle(zoo)
  end

  def contains?(zoo, animal) do
    Enum.member?(zoo, animal)
  end

  def see_animals(zoo, count) do
    # Enum.split returns a tuple so we have to pattern match on the result
    # to get the value we want out
    {_seen, to_see} = Enum.split(zoo, -count)
    to_see
  end

  def save(zoo, filename) do
    # erlang is converting the zoo list to something that can be written to the
    # file system
    binary = :erlang.term_to_binary(zoo)
    File.write(filename, binary)
  end

  def load(filename) do
    # here we are running a case expression on the result of File.read(filename)
    # if we receive an :ok then we want to return the list
    # if we receive an error then we want to give the user an error-friendly message
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
    end
  end

  def selection(number_of_animals) do
    # We are using the pipe operator here. It takes the value returned from
    # the expression and passes it down as the first argument in the expression
    # below. see_animals takes two arguments but only one needs to be specified
    # as the first is provided by the pipe operator
    Animals.create_zoo()
    |> Animals.randomise(zoo)
    |> Animals.see_animals(number_of_animals)
  end
end
