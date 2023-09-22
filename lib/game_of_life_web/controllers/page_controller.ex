defmodule GameOfLifeWeb.PageController do
  require Logger

  use GameOfLifeWeb, :controller

  import GameOfLife.Services.Grid

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  # def experiment(conn, _params) do
  #   Logger.info("Hello world! from experiment")
  #   Grid.create_grid(9, 9)
  # end
end
