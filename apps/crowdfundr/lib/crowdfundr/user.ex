defmodule Crowdfundr.User do
  @moduledoc """
  A user struct.
  """

  @type t :: %__MODULE__{
    id: String.t(),
    email: String.t()
  }

  defstruct [:id, :email]
end
