defmodule Cards do
  @moduledoc """
  Provide methods for creating and handling a deck of cards
  """

  @doc """
  Returns a list of strings representing a `deck` of playing cards

  ## Examples

      iex> Cards.create_deck
      ["ace of spades", "two of spades", "three of spades", "four of spades",
      "five of spades", "ace of clubs", "two of clubs", "three of clubs",
      "four of clubs", "five of clubs", "ace of hearts", "two of hearts",
      "three of hearts", "four of hearts", "five of hearts", "ace of diamonds",
      "two of diamonds", "three of diamonds", "four of diamonds", "five of diamonds"]

  """

  def create_deck do
    values = ["ace", "two", "three", "four", "five"]
    suits = ["spades", "clubs", "hearts", "diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Returns `deck` shuffled

  ## Examples

      iex> deck = Cards.create_deck()
      iex> shuffle_deck = Cards.shuffle(deck)
      iex> shuffle_deck == deck
      false

  """

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Returns `true` if `hand` is present on `deck`

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "ace of spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
  Split some cards in according of `hand_size` leaving the rest on `deck`.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "ace of spades")

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves on a binary file (`filename`) the `deck` created
  """
  def save_deck(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads a `deck` saved to a file (`filename`)
  """
  def load_deck(filename) do
    case File.read(filename) do
      {:ok, binary} ->
        :erlang.binary_to_term(binary)

      {:error, _reason} ->
        "That file does not exist"
    end
  end

  @doc """
  Divides a `deck` into a hand and the remainder of the deck.
  The `hand_size`argument indicates how many cards should
  be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _} = Cards.deal(deck, 4)
      iex> hand
      ["ace of spades", "two of spades", "three of spades", "four of spades"]

  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
