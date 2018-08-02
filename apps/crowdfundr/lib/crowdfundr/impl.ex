defmodule Crowdfundr.Impl do
  @moduledoc false

  alias Crowdfundr.Accounts.User
  alias Ecto.Changeset

  @callback register_user(map) :: {:ok, User.t()} | {:error, Changeset.t()}
end
