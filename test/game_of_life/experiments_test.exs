defmodule GameOfLife.ExperimentsTest do
  use GameOfLife.DataCase

  alias GameOfLife.Experiments

  describe "experiments" do
    alias GameOfLife.Experiments.Experiment

    import GameOfLife.ExperimentsFixtures

    @invalid_attrs %{name: nil, width: nil, height: nil, grid: nil}

    test "list_experiments/0 returns all experiments" do
      experiment = experiment_fixture()
      assert Experiments.list_experiments() == [experiment]
    end

    test "get_experiment!/1 returns the experiment with given id" do
      experiment = experiment_fixture()
      assert Experiments.get_experiment!(experiment.id) == experiment
    end

    test "create_experiment/1 with valid data creates a experiment" do
      valid_attrs = %{name: "some name", width: 42, height: 42, grid: []}

      assert {:ok, %Experiment{} = experiment} = Experiments.create_experiment(valid_attrs)
      assert experiment.name == "some name"
      assert experiment.width == 42
      assert experiment.height == 42
      assert experiment.grid == []
    end

    test "create_experiment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experiments.create_experiment(@invalid_attrs)
    end

    test "update_experiment/2 with valid data updates the experiment" do
      experiment = experiment_fixture()
      update_attrs = %{name: "some updated name", width: 43, height: 43, grid: []}

      assert {:ok, %Experiment{} = experiment} =
               Experiments.update_experiment(experiment, update_attrs)

      assert experiment.name == "some updated name"
      assert experiment.width == 43
      assert experiment.height == 43
      assert experiment.grid == []
    end

    test "update_experiment/2 with invalid data returns error changeset" do
      experiment = experiment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Experiments.update_experiment(experiment, @invalid_attrs)

      assert experiment == Experiments.get_experiment!(experiment.id)
    end

    test "delete_experiment/1 deletes the experiment" do
      experiment = experiment_fixture()
      assert {:ok, %Experiment{}} = Experiments.delete_experiment(experiment)
      assert_raise Ecto.NoResultsError, fn -> Experiments.get_experiment!(experiment.id) end
    end

    test "change_experiment/1 returns a experiment changeset" do
      experiment = experiment_fixture()
      assert %Ecto.Changeset{} = Experiments.change_experiment(experiment)
    end
  end
end
