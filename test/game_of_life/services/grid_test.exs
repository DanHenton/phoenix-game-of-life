defmodule GameOfLife.Services.GridTest do
  use ExUnit.Case

  alias GameOfLife.Services.Grid, as: Grid

  setup_all do
    {:ok, default_width: 5, default_height: 6}
  end

  setup %{default_width: default_width, default_height: default_height} do
    {:ok, grid: Grid.create_grid(default_width, default_height)}
  end

  describe "Grid" do
    test "#create_grid creates a 2d array of the population", %{
      default_width: default_width,
      default_height: default_height,
      grid: grid
    } do
      subject = grid

      assert length(subject) == default_height
      assert length(Enum.at(subject, 0)) == default_width
    end

    test "#create_grid creates a grid that only contains the values 1 or 2", %{grid: grid} do
      for row <- grid do
        assert Enum.all?(row, fn elem -> elem == 1 || elem == 2 end)
      end
    end

    test "#create_grid creates a random grid", %{
      default_width: default_width,
      default_height: default_height,
      grid: grid
    } do
      subject = Grid.create_grid(default_width, default_height)

      assert subject != grid
    end

    test "#dehydrate_grid flattens this grid", %{
      default_width: default_width,
      default_height: default_height,
      grid: grid
    } do
      subject = Grid.dehydrate_grid(grid)

      assert length(subject) == default_width * default_height
    end

    test "#hydrate_grid restores a flattened grid to the original 2d state", %{
      default_width: default_width,
      grid: grid
    } do
      dehydrated = Grid.dehydrate_grid(grid)

      subject = Grid.hydrate_grid(dehydrated, default_width)
      assert subject == grid
    end
  end
end
