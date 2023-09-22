defmodule GameOfLifeWeb.ExperimentLiveTest do
  use GameOfLifeWeb.ConnCase

  import Phoenix.LiveViewTest
  import GameOfLife.ExperimentsFixtures

  @create_attrs %{name: "some name", width: 42, height: 42}
  @update_attrs %{name: "some updated name", width: 43, height: 43}
  @invalid_attrs %{name: nil, width: nil, height: nil}

  defp create_experiment(_) do
    experiment = experiment_fixture()
    %{experiment: experiment}
  end

  describe "Index" do
    setup [:create_experiment]

    test "lists all experiments", %{conn: conn, experiment: experiment} do
      {:ok, _index_live, html} = live(conn, ~p"/experiments")

      assert html =~ "Listing Experiments"
      assert html =~ experiment.name
    end

    test "saves new experiment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/experiments")

      assert index_live |> element("a", "New Experiment") |> render_click() =~
               "New Experiment"

      assert_patch(index_live, ~p"/experiments/new")

      assert index_live
             |> form("#experiment-form", experiment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#experiment-form", experiment: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/experiments")

      html = render(index_live)
      assert html =~ "Experiment created successfully"
      assert html =~ "some name"
    end

    test "updates experiment in listing", %{conn: conn, experiment: experiment} do
      {:ok, index_live, _html} = live(conn, ~p"/experiments")

      assert index_live |> element("#experiments-#{experiment.id} a", "Edit") |> render_click() =~
               "Edit Experiment"

      assert_patch(index_live, ~p"/experiments/#{experiment}/edit")

      assert index_live
             |> form("#experiment-form", experiment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#experiment-form", experiment: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/experiments")

      html = render(index_live)
      assert html =~ "Experiment updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes experiment in listing", %{conn: conn, experiment: experiment} do
      {:ok, index_live, _html} = live(conn, ~p"/experiments")

      assert index_live |> element("#experiments-#{experiment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#experiments-#{experiment.id}")
    end
  end

  describe "Show" do
    setup [:create_experiment]

    test "displays experiment", %{conn: conn, experiment: experiment} do
      {:ok, _show_live, html} = live(conn, ~p"/experiments/#{experiment}")

      assert html =~ "Show Experiment"
      assert html =~ experiment.name
    end

    test "updates experiment within modal", %{conn: conn, experiment: experiment} do
      {:ok, show_live, _html} = live(conn, ~p"/experiments/#{experiment}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Experiment"

      assert_patch(show_live, ~p"/experiments/#{experiment}/show/edit")

      assert show_live
             |> form("#experiment-form", experiment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#experiment-form", experiment: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/experiments/#{experiment}")

      html = render(show_live)
      assert html =~ "Experiment updated successfully"
      assert html =~ "some updated name"
    end
  end
end
