defmodule GameOfLifeWeb.PageController do
  require Logger

  use GameOfLifeWeb, :controller

  import GameOfLife.Services.Grid

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    Logger.info("Hello world! from home")
    grid = create_grid(9, 9)
    Logger.info(display_grid(grid))
    # grid = Grid.create_grid(9, 9)
    render(conn, :home, layout: false, grid: grid)
  end

  # def experiment(conn, _params) do
  #   Logger.info("Hello world! from experiment")
  #   Grid.create_grid(9, 9)
  # end
end
