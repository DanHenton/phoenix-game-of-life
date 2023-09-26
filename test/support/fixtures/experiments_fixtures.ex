defmodule GameOfLife.ExperimentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GameOfLife.Experiments` context.
  """

  @doc """
  Generate a experiment.
  """
  def experiment_fixture(attrs \\ %{}) do
    {:ok, experiment} =
      attrs
      |> Enum.into(%{
        name: "some name",
        width: 42,
        height: 42,
        grid: []
      })
      |> GameOfLife.Experiments.create_experiment()

    experiment
  end
end
