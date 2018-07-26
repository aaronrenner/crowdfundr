defmodule CrowdfundrWeb.UserControllerTest do
  use CrowdfundrWeb.ConnCase, async: true

  test "GET new/2 renders form", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "Create an Account"
  end

  test "POST create/2 with valid params registers a user", %{conn: conn} do
    params = %{"email" => "a@a.com", "password" => "password"}

    conn = post conn, user_path(conn, :create), user: params

    assert redirected_to(conn) == page_path(conn,  :index)
  end

  test "POST create/2 rerenders form", %{conn: conn} do
    params = %{}

    conn = post conn, user_path(conn, :create), user: params
    assert html_response(conn, 200) =~ "Create an Account"
  end
end
