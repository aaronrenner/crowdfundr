defmodule Crowdfundr.Impl do
  @moduledoc false

  alias Crowdfundr.Accounts.User
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError

  @callback register_user(map) :: {:ok, User.t()} | {:error, EmailAlreadyRegisteredError.t() | InvalidDataError.t()}
end
