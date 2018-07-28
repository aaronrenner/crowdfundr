defmodule CrowdfundrWeb.UserControllerTest do
  use CrowdfundrWeb.ConnCase, async: true

  alias Crowdfundr.UserEmail

  import Swoosh.TestAssertions

  test "GET new/2 renders form", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "Create an Account"
  end

  test "POST create/2 with valid params registers a user", %{conn: conn} do
    email = "a@a.com"
    params = %{"email" => email, "password" => "password"}

    conn = post conn, user_path(conn, :create), user: params

    assert redirected_to(conn) == page_path(conn,  :index)
    assert_email_sent UserEmail.welcome(email)
    # How do we test the metrics are sent?
  end

  test "POST create/2 rerenders form", %{conn: conn} do
    params = %{}

    conn = post conn, user_path(conn, :create), user: params
    assert html_response(conn, 200) =~ "Create an Account"
  end
end
