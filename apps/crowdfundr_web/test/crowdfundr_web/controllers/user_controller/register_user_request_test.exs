defmodule CrowdfundrWeb.UserController.RegisterUserRequestTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import Mox

  alias Crowdfundr.Accounts.User
  alias CrowdfundrWeb.MockCrowdfundr
  alias CrowdfundrWeb.UserController.RegisterUserRequest
  alias Ecto.Changeset

  setup [:set_mox_from_context, :verify_on_exit!]

  test "run/1 calls register_user with the correct params" do
    check all params <- fixed_map(%{
      "email" => string(:alphanumeric, min_length: 1),
      "password" => string(:alphanumeric, min_length: 8)
    }) do
      %{
        "email" => email,
        "password" => password,
      } = params

      params = Map.put(params, "password_confirmation", password)

      user = %User{email: email}

      MockCrowdfundr
      |> expect(:register_user, fn %{email: ^email, password: ^password} ->
        {:ok, user}
      end)

      assert {:ok, ^user} = RegisterUserRequest.run(params)
    end
  end

  test "run/1 with missing params" do
    params = %{}

    assert {:error, %Changeset{} = changeset} = RegisterUserRequest.run(params)
    assert "can't be blank" in errors_on(changeset).email
    assert "can't be blank" in errors_on(changeset).password
  end

  test "run/1 with too short of a password" do
    {:error, changeset} = RegisterUserRequest.run(%{password: "a"})
    assert "should be at least 8 character(s)" in errors_on(changeset).password
  end

  test "run/1 when register_user returns an error" do
    email = "foo@example.com"
    password = "password"

    params = %{"email" => email, "password" => password, "password_confirmation" => password}

    MockCrowdfundr
    |> expect(:register_user, fn %{email: ^email, password: ^password} ->
      changeset = %User{} |> Changeset.change() |> Changeset.add_error(:email, "is already taken")
      {:error, changeset}
    end)

    assert {:error, %Changeset{data: %RegisterUserRequest{}, action: :insert} = changeset} = RegisterUserRequest.run(params)
    assert "is already taken" in errors_on(changeset).email
  end

  @doc """
  A helper that transform changeset errors to a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
