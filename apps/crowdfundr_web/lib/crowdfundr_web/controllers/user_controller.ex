defmodule CrowdfundrWeb.UserController do
  use CrowdfundrWeb, :controller

  alias Crowdfundr.Accounts
  alias Crowdfundr.Accounts.User
  alias Crowdfundr.Mailer
  alias Crowdfundr.Statsd
  alias Crowdfundr.UserEmail
  alias Ecto.Changeset

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case register_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @spec register_user(map) :: {:ok, User.t()} | {:error, Changeset.t()}
  defp register_user(user_params) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        # Send welcome email
        user.email |> UserEmail.welcome |> Mailer.deliver

        # Send event to statsd
        Statsd.increment("user_registered")

        {:ok, user}
      {:error, %Changeset{} = changeset} ->
        {:error, changeset}
    end
  end
end
