defmodule GameOfLifeWeb.ExperimentLive.FormComponent do
  use GameOfLifeWeb, :live_component

  alias GameOfLife.Experiments

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage experiment records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="experiment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:width]} type="number" label="Width" />
        <.input field={@form[:height]} type="number" label="Height" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Experiment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{experiment: experiment} = assigns, socket) do
    changeset = Experiments.change_experiment(experiment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"experiment" => experiment_params}, socket) do
    changeset =
      socket.assigns.experiment
      |> Experiments.change_experiment(experiment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"experiment" => experiment_params}, socket) do
    save_experiment(socket, socket.assigns.action, experiment_params)
  end

  defp save_experiment(socket, :edit, experiment_params) do
    case Experiments.update_experiment(socket.assigns.experiment, experiment_params) do
      {:ok, experiment} ->
        notify_parent({:saved, experiment})

        {:noreply,
         socket
         |> put_flash(:info, "Experiment updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_experiment(socket, :new, experiment_params) do
    case Experiments.create_experiment(experiment_params) do
      {:ok, experiment} ->
        notify_parent({:saved, experiment})

        {:noreply,
         socket
         |> put_flash(:info, "Experiment created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
