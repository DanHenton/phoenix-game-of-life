defmodule GameOfLife.Service.GameLogicTest do
  use ExUnit.Case
  require Logger

  alias GameOfLife.Services.GameLogic, as: GameLogic

  describe "GameLogic specifics" do
    test "Rule#1 Underpopulation" do
      grid = [
        [2, 1, 1, 1],
        [1, 2, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 2]
      ]

      expected = [
        [2, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1]
      ]

      subject = GameLogic.next_generation(grid)

      assert subject == expected
    end

    test "Rule#2 Stable population (Two neighbors)" do
      grid = [
        [1, 1, 1, 1],
        [1, 1, 2, 1],
        [1, 2, 2, 1],
        [1, 1, 1, 1]
      ]

      expected = [
        [1, 1, 1, 1],
        [1, 2, 2, 1],
        [1, 2, 2, 1],
        [1, 1, 1, 1]
      ]

      subject = GameLogic.next_generation(grid)

      assert subject == expected
    end

    test "Rule#2 Stable population (Three neighbors)" do
      grid = [
        [1, 1, 1, 1],
        [1, 2, 2, 1],
        [1, 2, 2, 1],
        [1, 1, 1, 1]
      ]

      expected = [
        [1, 1, 1, 1],
        [1, 2, 2, 1],
        [1, 2, 2, 1],
        [1, 1, 1, 1]
      ]

      subject = GameLogic.next_generation(grid)

      assert subject == expected
    end

    test "Rule#3 Overpopulation kills cells" do
      grid = [
        [1, 1, 2, 1],
        [1, 2, 2, 2],
        [1, 1, 2, 1],
        [1, 1, 1, 1]
      ]

      expected = [
        [1, 2, 2, 2],
        [1, 2, 1, 2],
        [1, 2, 2, 2],
        [1, 1, 1, 1]
      ]

      subject = GameLogic.next_generation(grid)

      assert subject == expected
    end

    test "Rule#4 Reproduction" do
      grid = [
        [1, 2, 1, 1],
        [1, 1, 2, 1],
        [1, 2, 1, 1],
        [1, 1, 1, 1]
      ]

      expected = [
        [1, 1, 1, 1],
        [1, 2, 2, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1]
      ]

      subject = GameLogic.next_generation(grid)

      assert subject == expected
    end
  end

  describe "GameLogic glider" do
    setup do
      {:ok,
       width: 4,
       height: 4,
       glider_generations: [
         [[2, 1, 1, 1], [1, 2, 2, 1], [2, 1, 1, 1], [1, 1, 1, 1]],
         [[1, 2, 1, 1], [2, 2, 1, 2], [1, 2, 1, 1], [1, 1, 1, 1]],
         [[1, 2, 2, 1], [1, 2, 1, 1], [1, 2, 2, 1], [1, 1, 1, 1]],
         [[1, 2, 2, 1], [2, 1, 1, 1], [1, 2, 2, 1], [1, 1, 1, 1]],
         [[1, 2, 1, 1], [2, 1, 1, 2], [1, 2, 1, 1], [1, 1, 1, 1]],
         [[2, 1, 1, 1], [2, 2, 2, 1], [2, 1, 1, 1], [1, 1, 1, 1]],
         [[2, 1, 1, 2], [2, 1, 1, 1], [2, 1, 1, 2], [1, 1, 1, 1]],
         [[2, 1, 1, 2], [1, 2, 1, 1], [2, 1, 1, 2], [1, 1, 1, 1]]
       ]}
    end

    test "#next_generation transitions the glider through its generations and back to its beginning",
         %{glider_generations: glider_generations} do
      Enum.with_index(glider_generations, fn generation, index ->
        next_index =
          if index == length(glider_generations) - 1 do
            0
          else
            index + 1
          end

        expected = Enum.at(glider_generations, next_index)

        assert GameLogic.next_generation(generation) == expected
      end)
    end
  end
end
