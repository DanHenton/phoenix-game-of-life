defmodule GameOfLifeWeb.ExperimentLive.Show do
  use GameOfLifeWeb, :live_view
  alias GameOfLife.Experiments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:experiment, Experiments.get_experiment!(id))}
  end

  defp page_title(:show), do: "Show Experiment"
  defp page_title(:edit), do: "Edit Experiment"

  defp empty?(grid) do
    is_nil(grid) || length(grid) == 0
  end

  @impl true
  def handle_event("start_experiment", %{"experiment_id" => experiment_id}, socket) do
    experiment = Experiments.get_experiment!(experiment_id)

    case experiment.grid do
      nil ->
        # new_grid = GameOfLife.Services.Grid.create_grid(experiment.width, experiment.height)
        new_grid = GameOfLife.Services.Grid.create_grid(experiment.width, experiment.height)

        updated_experiment = update_experiment_grid(experiment, new_grid)
        {:noreply, assign(socket, experiment: updated_experiment)}

      _ ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("next_generation", %{"experiment_id" => experiment_id}, socket) do
    experiment = Experiments.get_experiment!(experiment_id)
    grid = GameOfLife.Services.Grid.hydrate_grid(experiment.grid, experiment.width)

    case grid do
      _ ->
        next_generation =
          GameOfLife.Services.Rules.next_generation(grid, experiment.width, experiment.height)

        updated_experiment = update_experiment_grid(experiment, next_generation)
        {:noreply, assign(socket, experiment: updated_experiment)}
    end
  end

  defp update_experiment_grid(experiment, new_grid) do
    grid = GameOfLife.Services.Grid.dehydrate_grid(new_grid)

    experiment
    |> Experiments.Experiment.changeset(%{grid: grid})
    |> GameOfLife.Repo.update!()
  end
end
