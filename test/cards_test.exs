defmodule CardsTest do
  use ExUnit.Case
  doctest Cards


  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    #assert will show if it's true or not
    assert deck_length == 20
  end

  test "shuffling a deck randomizes it" do
      deck = Cards.create_deck
      refute deck == Cards.shuffle(deck)
      #same as assert != .....
  end

  
end
