defmodule CrowdfundrWeb.UserController.RegisterUserRequest do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias Crowdfundr.Accounts.User
  alias Ecto.Changeset

  @type t :: %__MODULE__{
    email: String.t() | nil,
    password: String.t() | nil,
    password_confirmation: String.t() | nil
  }

  @primary_key false
  embedded_schema do
    field :email, :string
    field :password, :string
    field :password_confirmation, :string
  end

  @spec run(map) :: {:ok, User.t()} | {:error, Changeset.t()}
  def run(params) do
    changeset = changeset(%__MODULE__{}, params)

    with {:ok, request} <- apply_action(changeset, :insert) do
      register_user(request, changeset)
    end
  end

  @spec changeset(t, map()) :: Changeset.t()
  def changeset(request \\ %__MODULE__{}, params \\ %{}) do
    request
    |> cast(params, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password, message: "does not match password", required: true)
  end

  @spec register_user(t, Changeset.t()) :: {:ok, User.t()} |{:error, Changeset.t()}
  defp register_user(%__MODULE__{email: email, password: password}, changeset) do
    case Crowdfundr.register_user(%{email: email, password: password}) do
      {:ok, user} ->
        {:ok, user}

      {:error, user_changeset} ->
        changeset =
          user_changeset.errors
          |> Enum.reduce(changeset, fn {field, {message, opts}}, changeset ->
            Changeset.add_error(changeset, field, message, opts)
          end)
          |> set_changeset_action(:insert) # Webform needs action to be set to display errors
          {:error, changeset}
    end
  end

  defp set_changeset_action(changeset, action) do
    %Changeset{changeset | action: action}
  end
end
