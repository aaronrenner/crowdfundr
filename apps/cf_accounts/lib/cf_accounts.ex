defmodule CFAccounts do
  @moduledoc """
  Internal API for working with accounts.
  """

  import Constantizer

  alias CFAccounts.DefaultImpl
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.User

  @type user_id :: String.t()

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

  """
  @spec create_user(map) ::
          {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
  def create_user(attrs \\ %{}) do
    impl().create_user(attrs)
  end

  defconstp impl do
    Application.get_env(:cf_accounts, :impl, DefaultImpl)
  end
end
