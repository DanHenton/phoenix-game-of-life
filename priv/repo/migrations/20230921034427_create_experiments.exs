defmodule GameOfLife.Repo.Migrations.CreateExperiments do
  use Ecto.Migration

  def change do
    create table(:experiments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :width, :integer
      add :height, :integer
      add :grid, {:array, :integer}

      timestamps()
    end
  end
end
