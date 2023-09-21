defmodule GameOfLife.Services.Grid do
  require Logger
  # # require IEx; IEx.pry

  @spec create_grid(integer :: integer, any :: integer ) :: list
  def create_grid(width, height) do
    Enum.map(1..width, fn _ ->
      Enum.map(1..height, fn _ ->
        :rand.uniform(2)
      end)
    end)
  end


  def display_grid(grid) do
    Enum.each(grid, fn row ->
      Enum.map(row, &(if &1 == 1, do: "🦠", else: " "))
    end)
  end

  def log_grid(grid) do
    Logger.log(display_grid(grid))
  end
end
