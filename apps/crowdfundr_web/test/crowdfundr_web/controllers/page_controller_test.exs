defmodule CrowdfundrWeb.PageControllerTest do
  use CrowdfundrWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Crowdfundr!"
  end
end
