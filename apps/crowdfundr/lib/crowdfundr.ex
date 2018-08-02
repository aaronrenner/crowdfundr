defmodule Crowdfundr do
  @moduledoc """
  Crowdfundr Public API.
  """

  alias Crowdfundr.Accounts.User
  alias Crowdfundr.DefaultImpl
  alias Ecto.Changeset

  @behaviour Crowdfundr.Impl

  @doc """
  Register a user.
  """
  @spec register_user(map) :: {:ok, User.t()} | {:error, Changeset.t()}
  def register_user(user_params) do
    impl().register_user(user_params)
  end

  defp impl do
    Application.get_env(:crowdfundr, :impl, DefaultImpl)
  end
end
