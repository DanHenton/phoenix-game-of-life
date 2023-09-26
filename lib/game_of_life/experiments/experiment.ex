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
    |> validate_inclusion(:width, 1..50)
    |> validate_inclusion(:height, 1..50)
  end
end
