defmodule CFMetrics.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias CFMetrics.DefaultImpl.Statsd

  def start(_type, _args) do
    :ok = Statsd.connect()

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: CFMetrics.Worker.start_link(arg)
      # {CFMetrics.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CFMetrics.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
