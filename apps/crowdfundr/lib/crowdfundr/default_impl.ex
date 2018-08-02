defmodule Crowdfundr.DefaultImpl do
  @moduledoc false

  alias Crowdfundr.Accounts
  alias Crowdfundr.Accounts.User
  alias Crowdfundr.Mailer
  alias Crowdfundr.Statsd
  alias Crowdfundr.UserEmail
  alias Ecto.Changeset

  @behaviour Crowdfundr.Impl

  @spec register_user(map) :: {:ok, User.t()} | {:error, Changeset.t()}
  def register_user(user_params) do
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
