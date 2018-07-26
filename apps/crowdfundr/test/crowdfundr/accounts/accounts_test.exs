defmodule Crowdfundr.AccountsTest do
  use Crowdfundr.DataCase

  alias Crowdfundr.Accounts

  describe "users" do
    alias Comeonin.Argon2
    alias Crowdfundr.Accounts.User

    @valid_attrs %{email: "some email", password: "some password"}
    @update_attrs %{email: "some updated email", password: "some updated password"}
    @invalid_attrs %{email: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      %User{id: user_id} = user_fixture()
      assert [%User{id: ^user_id}] = Accounts.list_users()
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

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert Argon2.checkpw("some updated password", user.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      %User{id: user_id} = user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert %User{id: ^user_id} = Accounts.get_user!(user_id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
