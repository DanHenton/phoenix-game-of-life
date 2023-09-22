defmodule GameOfLife.Services.Rules do
  require Logger

  def next_generation(grid, width, height) do
    Logger.info("next_generation")

    Enum.map(1..height, fn y ->
      Enum.map(1..width, fn x ->
        cell = Enum.at(Enum.at(grid, y - 1), x - 1)
        live_neighbors = count_live_neighbors(grid, x, y, width, height)

        if cell == 1 do
          if live_neighbors < 2 or live_neighbors > 3 do
            0
          else
            1
          end
        else
          if live_neighbors == 3 do
            1
          else
            0
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
      cell == 1
    end)
  end
end
