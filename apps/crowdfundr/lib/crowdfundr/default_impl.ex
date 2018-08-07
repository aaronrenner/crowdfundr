defmodule Crowdfundr.DefaultImpl do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Accounts
  alias Crowdfundr.DefaultImpl.Mailer
  alias Crowdfundr.DefaultImpl.Statsd
  alias Crowdfundr.DefaultImpl.UserEmail
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.User

  @behaviour Crowdfundr.Impl

  @spec register_user(map) :: {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
  def register_user(user_params) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      # Send welcome email
      user.email |> UserEmail.welcome |> Mailer.deliver

      # Send event to statsd
      Statsd.increment("user_registered")

      {:ok, user}
    end
  end
end
