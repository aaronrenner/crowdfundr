defmodule Crowdfundr.DefaultImpl.Accounts do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Accounts.DefaultImpl
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
  @spec create_user(map) :: {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
  def create_user(attrs \\ %{}) do
    impl().create_user(attrs)
  end

  defp impl do
    Application.get_env(:crowdfundr, :accounts_impl, DefaultImpl)
  end
end
