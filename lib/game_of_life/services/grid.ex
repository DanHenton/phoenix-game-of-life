defmodule GameOfLife.Services.Grid do
  require Logger

  @spec create_grid(integer :: integer, any :: integer) :: list
  def create_grid(width, height) do
    Enum.map(1..height, fn _ ->
      Enum.map(1..width, fn _ ->
        :rand.uniform(2)
      end)
    end)
  end

  @spec hydrate_grid(any, pos_integer) :: [list]
  def hydrate_grid(flat_grid, width) do
    Enum.chunk_every(flat_grid, width)
  end

  @spec dehydrate_grid(list) :: list
  def dehydrate_grid(grid) do
    List.flatten(grid)
  end

  @spec display_grid(any) :: [list]
  def display_grid(grid) do
    Enum.map(grid, fn row ->
      col = Enum.map(row, &if(&1 == 1, do: " ", else: "🦠"))
      Logger.info("\t #{col}")

      col
    end)
  end
end
