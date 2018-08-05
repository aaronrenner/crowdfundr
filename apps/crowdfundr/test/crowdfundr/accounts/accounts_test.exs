defmodule Crowdfundr.AccountsTest do
  use Crowdfundr.DataCase

  alias Crowdfundr.Accounts

  describe "users" do
    alias Comeonin.Argon2
    alias Crowdfundr.Accounts.User

    @valid_attrs %{email: "some email", password: "some password"}
    @invalid_attrs %{email: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      %User{id: user_id} = user_fixture()
      assert %User{id: ^user_id} = Accounts.get_user!(user_id)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert Argon2.checkpw("some password", user.password_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
