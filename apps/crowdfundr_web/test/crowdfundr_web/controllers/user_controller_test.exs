defmodule CrowdfundrWeb.UserControllerTest do
  use CrowdfundrWeb.ConnCase, async: true

  import Mox

  alias Crowdfundr.Accounts.User
  alias CrowdfundrWeb.MockCrowdfundr
  alias Ecto.Changeset

  setup [:set_mox_from_context, :verify_on_exit!]

  test "GET new/2 renders form", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "Create an Account"
  end

  test "POST create/2 with valid params registers a user", %{conn: conn} do
    email = "a@a.com"
    params = %{"email" => email, "password" => "password"}

    expect(MockCrowdfundr, :register_user, fn ^params ->
      {:ok, %User{id: "123", email: "a@a.com"}}
    end)

    conn = post conn, user_path(conn, :create), user: params

    assert redirected_to(conn) == page_path(conn,  :index)
  end

  test "POST create/2 rerenders form", %{conn: conn} do
    params = %{}

    expect(MockCrowdfundr, :register_user, fn ^params ->
      {:error, build_invalid_changeset()}
    end)

    conn = post conn, user_path(conn, :create), user: params
    assert html_response(conn, 200) =~ "Create an Account"
  end

  defp build_invalid_changeset do
    %User{}
    |> Changeset.change(email: "email")
    |> Changeset.add_error(:email, "is invalid")
  end
end
