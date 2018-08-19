defmodule CFAccounts.DefaultImplTest do
  use CFAccounts.DataCase
  use ExUnitProperties

  alias CFAccounts.DefaultImpl
  alias Crowdfundr.EmailAlreadyRegisteredError
  alias Crowdfundr.InvalidDataError

  describe "users" do
    alias Crowdfundr.User

    @valid_attrs %{email: "some email", password: "some password"}
    @invalid_attrs %{email: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DefaultImpl.create_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      %User{id: user_id} = user_fixture()
      assert %User{id: ^user_id} = DefaultImpl.get_user!(user_id)
    end

    test "create_user/1 with valid data creates a user" do
      email = "aaron@example.com"
      password = "foo"

      assert {:ok, %User{id: id}} = DefaultImpl.create_user(%{email: email, password: password})

      assert {:ok, %User{id: ^id}} = DefaultImpl.fetch_by_email_and_password(email, password)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %InvalidDataError{}} = DefaultImpl.create_user(@invalid_attrs)
    end

    test "create_user/1 when email has already been taken" do
      {:ok, _} = DefaultImpl.create_user(@valid_attrs)
      assert {:error, %EmailAlreadyRegisteredError{}} = DefaultImpl.create_user(@valid_attrs)
    end

    property "fetch_by_email_and_password/2 with valid credentials" do
      valid_email = "aaron@example.com"
      valid_password = "password"

      {:ok, %User{id: id}} =
        DefaultImpl.create_user(%{email: valid_email, password: valid_password})

      check all email <- one_of([constant(valid_email), string(:alphanumeric)]),
                password <- one_of([constant(valid_password), string(:alphanumeric)]) do
        if email == valid_email && password == valid_password do
          assert {:ok, %User{id: ^id}} = DefaultImpl.fetch_by_email_and_password(email, password)
        else
          assert {:error, :not_found} = DefaultImpl.fetch_by_email_and_password(email, password)
        end
      end
    end
  end
end
