defmodule Crowdfundr.Application do
  @moduledoc """
  The Crowdfundr Application Service.

  The crowdfundr system business domain lives in this application.

  Exposes API to clients such as the `CrowdfundrWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Crowdfundr.Repo, []),
    ], strategy: :one_for_one, name: Crowdfundr.Supervisor)
  end
end
