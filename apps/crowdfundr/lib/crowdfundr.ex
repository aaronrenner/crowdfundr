defmodule Crowdfundr do
  @moduledoc """
  Crowdfundr Public API.
  """

  alias Crowdfundr.DefaultImpl
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.User

  @behaviour Crowdfundr.Impl

  @doc """
  Register a user.
  """
  @spec register_user(map) :: {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
  def register_user(user_params) do
    impl().register_user(user_params)
  end

  defp impl do
    Application.get_env(:crowdfundr, :impl, DefaultImpl)
  end
end
