defmodule GameOfLifeWeb.PageControllerTest do
  use GameOfLifeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "🦠"
  end
end
