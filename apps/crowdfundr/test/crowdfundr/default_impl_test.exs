defmodule Crowdfundr.DefaultImplTest do
  use ExUnit.Case, async: true

  import Mox

  alias Crowdfundr.DefaultImpl
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.MockAccounts
  alias Crowdfundr.MockCFEmails
  alias Crowdfundr.MockMetrics
  alias Crowdfundr.User

  setup [:set_mox_from_context, :verify_on_exit!]

  test "register_user/1 with valid data" do
    email = "user@example.com"
    password = "secret"
    params = %{email: email, password: password}
    user = %User{id: "foo", email: email}

    expect(MockAccounts, :create_user, fn ^params -> {:ok, user} end)
    expect(MockMetrics, :send_user_registered, fn -> :ok end)
    expect(MockCFEmails, :send_welcome, fn ^email -> :ok end)

    assert {:ok, ^user} = DefaultImpl.register_user(params)
  end

  test "register_user/1 with invalid data" do
    params = %{}

    expect(MockAccounts, :create_user, fn ^params ->
      {:error, InvalidDataError.exception(errors: [])}
    end)

    assert {:error, %InvalidDataError{}} = DefaultImpl.register_user(params)
  end
end
