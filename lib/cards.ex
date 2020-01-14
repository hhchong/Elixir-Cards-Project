defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  Provides methods for creatings and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      #doubled up comprehension, which is like flattened nested loop
        #take value inject it into here and inject suit into here
        "#{value} of #{suit}"
      #for every element in suits, goes through do block, returns new array
      #"Is this a map?" will return it each I times
    end
  
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples
      
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck to a hand and the remainder of the deck
    The `hand_size` argument indicates how many cards should be in the hand.
  
  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    #split list into two diff lists, in curly brace tuples
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    # {status, binary} = File.read(filename)

    #"atom" for words with : -- think of them exactly like strings
    case File.read(filename) do 
      #does pattern matching to ok and error
      #does two things: compare result to File.read AND assigning second part of File.read to binary
      {:ok, binary} -> :erlang.binary_to_term binary
      #underscore tells elixir we dont really care -- wont get warning for using reason as variable
      {:error, _reason} -> "That file does not exist"
    end

    # :erlang.binary_to_term binary
  end

  def create_hand(hand_size) do
    #Pipe Operator
    #result of each method automatically sent on to next
    Cards.create_deck
    #returns deck, pass to cards.shuffle
    |> Cards.shuffle
    #result of shuffle passes to deal, will automatically inject as first argument
    |> Cards.deal(hand_size)
  end
end
