defmodule Crowdfundr.DefaultImpl do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Accounts
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.User

  @behaviour Crowdfundr.Impl

  @spec register_user(map) :: {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
  def register_user(user_params) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      CFEmails.send_welcome(user.email)
      CFMetrics.send_user_registered()

      {:ok, user}
    end
  end
end
