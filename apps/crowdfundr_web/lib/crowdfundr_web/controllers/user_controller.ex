defmodule CrowdfundrWeb.UserController do
  use CrowdfundrWeb, :controller

  alias Crowdfundr.Accounts
  alias Crowdfundr.Accounts.User
  alias Crowdfundr.Mailer
  alias Crowdfundr.Statsd
  alias Crowdfundr.UserEmail

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        # Send welcome email
        user.email |> UserEmail.welcome |> Mailer.deliver

        # Send event to statsd
        Statsd.increment("user_registered")

        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
