defmodule Crowdfundr.Application do
  @moduledoc false
  use Application

  alias Crowdfundr.DefaultImpl.Statsd

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    :ok = Statsd.connect()

    Supervisor.start_link([
      supervisor(Crowdfundr.DefaultImpl.Accounts.Repo, []),
    ], strategy: :one_for_one, name: Crowdfundr.Supervisor)
  end
end
