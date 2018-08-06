defmodule Crowdfundr.AccountsTest do
  use Crowdfundr.DataCase
  use ExUnitProperties

  alias Crowdfundr.Accounts

  describe "users" do
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
      email = "aaron@example.com"
      password = "foo"

      assert {:ok, %User{id: id}} =
        Accounts.create_user(%{email: email, password: password})
      assert {:ok, %User{id: ^id}} = Accounts.fetch_by_email_and_password(email, password)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    property "fetch_by_email_and_password/2 with valid credentials" do
      valid_email = "aaron@example.com"
      valid_password = "password"
      {:ok, %User{id: id}} = Accounts.create_user(%{email: valid_email, password: valid_password})

      check all email <- one_of([constant(valid_email), string(:alphanumeric)]),
                password <- one_of([constant(valid_password), string(:alphanumeric)]) do
        if email == valid_email && password == valid_password do
          assert {:ok, %User{id: ^id}} =
            Accounts.fetch_by_email_and_password(email, password)
        else
          assert {:error, :not_found} =
            Accounts.fetch_by_email_and_password(email, password)
        end
      end
    end
  end
end
