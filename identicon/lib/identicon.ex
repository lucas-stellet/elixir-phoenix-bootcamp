defmodule Identicon do
  @moduledoc false

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def mirror_row(grid) do
    # Enum.drop(grid, -1)
    Enum.map(grid, fn [f, s, t] = _r -> [f, s, t, s, f] end)
  end

  def build_grid(image) do
    grid =
      Enum.chunk_every(image.hex, 3, :discard)
      |> mirror_row()

    %Identicon.Image{image | grid: grid}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
