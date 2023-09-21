defmodule GameOfLifeWeb.ExperimentLive.Index do
  use GameOfLifeWeb, :live_view

  alias GameOfLife.Experiments
  alias GameOfLife.Experiments.Experiment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :experiments, Experiments.list_experiments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Experiment")
    |> assign(:experiment, Experiments.get_experiment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Experiment")
    |> assign(:experiment, %Experiment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Experiments")
    |> assign(:experiment, nil)
  end

  @impl true
  def handle_info({GameOfLifeWeb.ExperimentLive.FormComponent, {:saved, experiment}}, socket) do
    {:noreply, stream_insert(socket, :experiments, experiment)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    experiment = Experiments.get_experiment!(id)
    {:ok, _} = Experiments.delete_experiment(experiment)

    {:noreply, stream_delete(socket, :experiments, experiment)}
  end
end
