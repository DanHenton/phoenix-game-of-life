defmodule GameOfLife.Services.GameLogic do
  @dead 1
  @alive 2

  @spec next_generation([list]) :: [list]
  def next_generation(grid) do
    if Enum.empty?(grid) do
      {:halt, []}
    end

    height = length(grid)
    width = length(Enum.at(grid, 0))

    Enum.map(1..height, fn y ->
      Enum.map(1..width, fn x ->
        cell = Enum.at(Enum.at(grid, y - 1), x - 1)
        live_neighbors = count_live_neighbors(grid, x, y, width, height)

        if cell == @alive do
          if live_neighbors < 2 or live_neighbors > 3 do
            @dead
          else
            @alive
          end
        else
          if live_neighbors == 3 do
            @alive
          else
            @dead
          end
        end
      end)
    end)
  end

  defp count_live_neighbors(grid, x, y, width, height) do
    neighbors =
      [
        {x - 1, y - 1},
        {x, y - 1},
        {x + 1, y - 1},
        {x - 1, y},
        {x + 1, y},
        {x - 1, y + 1},
        {x, y + 1},
        {x + 1, y + 1}
      ]

    Enum.count(neighbors, fn {nx, ny} ->
      cell = Enum.at(Enum.at(grid, rem(ny - 1, height)), rem(nx - 1, width))
      cell == @alive
    end)
  end
end
