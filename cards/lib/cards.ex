defmodule Cards do
  @moduledoc false
  def create_deck do
    values = ["ace", "two", "three", "four", "five"]
    suits = ["spades", "clubs", "hearts", "diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
end
