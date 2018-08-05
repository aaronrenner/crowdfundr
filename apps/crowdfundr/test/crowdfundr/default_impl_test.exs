defmodule Crowdfundr.DefaultImplTest do
  use Crowdfundr.DataCase, async: true

  import Swoosh.TestAssertions

  alias Crowdfundr.Accounts
  alias Crowdfundr.Accounts.User
  alias Crowdfundr.DefaultImpl
  alias Crowdfundr.InvalidDataError
  alias Crowdfundr.UserEmail

  test "register_user/1 with valid data" do
    email = "user@example.com"
    password = "secret"
    params = %{email: email, password: password}

    assert {:ok, %User{id: id, email: ^email}} =
      DefaultImpl.register_user(params)

    assert %User{id: id, email: ^email} = Accounts.get_user!(id)
    assert_email_sent UserEmail.welcome(email)
    # How do we test the metrics are sent?
  end

  test "register_user/1 with invalid data" do
    assert {:error, %InvalidDataError{}} = DefaultImpl.register_user(%{})
  end
end
