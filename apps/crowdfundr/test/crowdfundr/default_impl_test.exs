defmodule Crowdfundr.DefaultImplTest do
  use Crowdfundr.DataCase, async: true

  import Mox

  alias Crowdfundr.Accounts
  alias Crowdfundr.DefaultImpl
  alias Crowdfundr.DefaultImpl.Accounts
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.MockEmails
  alias Crowdfundr.MockMetrics
  alias Crowdfundr.User

  setup [:set_mox_from_context, :verify_on_exit!]

  test "register_user/1 with valid data" do
    email = "user@example.com"
    password = "secret"
    params = %{email: email, password: password}

    expect(MockMetrics, :send_user_registered, fn -> :ok end)
    expect(MockEmails, :send_welcome, fn ^email -> :ok end)

    assert {:ok, %User{id: id, email: ^email}} =
      DefaultImpl.register_user(params)

    assert %User{id: id, email: ^email} = Accounts.get_user!(id)
  end

  test "register_user/1 with invalid data" do
    assert {:error, %InvalidDataError{}} = DefaultImpl.register_user(%{})
  end
end
