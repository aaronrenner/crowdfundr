defmodule CrowdfundrWeb.UserController do
  use CrowdfundrWeb, :controller

  alias CrowdfundrWeb.UserController.RegisterUserRequest

  def new(conn, _params) do
    changeset = RegisterUserRequest.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case RegisterUserRequest.run(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
