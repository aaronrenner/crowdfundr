defmodule Crowdfundr.InvalidDataError do
  @moduledoc """
  Indicates a record could not be persisted due to invalid data.
  """

  @type t :: %__MODULE__{
    message: String.t(),
    errors: term
  }

  defexception [:message, :errors]

  def exception(opts) do
    errors = Keyword.fetch!(opts, :errors)
    message = """
    unable to persist record because data is invalid

    errors:
    #{inspect(errors)}
    """

    %__MODULE__{message: message, errors: errors}
  end
end

defmodule Crowdfundr.EmailAlreadyRegisteredError do
  @moduledoc """
  Indicates an email could not be used because it is already
  registered to another user.
  """

  @type t :: %__MODULE__{
    message: String.t(),
    email: String.t()
  }

  defexception [:message, :email]

  def exception(opts) do
    email = Keyword.fetch!(opts, :email)
    message = "#{email} is already registered"

    %__MODULE__{message: message, email: email}
  end
end
