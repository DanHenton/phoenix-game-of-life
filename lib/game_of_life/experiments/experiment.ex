defmodule GameOfLife.Experiments.Experiment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "experiments" do
    field :name, :string
    field :width, :integer
    field :height, :integer
    field :grid, {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:name, :width, :height, :grid])
    |> validate_required([:name, :width, :height])
    # |> grid_reset()
  end

  # defp grid_reset(changeset) do
  #   if Map.has_key?(changeset.changes, :width) || Map.has_key?(changeset.changes, :height) do
  #     changeset
  #     |> put_change(:grid, GameOfLife.Services.Grid.dehydrate_grid(GameOfLife.Services.Grid.create_grid(changeset.changes[:width], changeset.changes[:height])))
  #   end
  # end
end
