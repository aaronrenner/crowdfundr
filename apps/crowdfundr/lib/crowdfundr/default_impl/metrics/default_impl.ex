defmodule Crowdfundr.DefaultImpl.Metrics.DefaultImpl do
  @moduledoc false

  alias Crowdfundr.DefaultImpl.Metrics.DefaultImpl.Statsd

  @behaviour Crowdfundr.DefaultImpl.Metrics.Impl

  @impl true
  @spec send_user_registered :: :ok
  def send_user_registered do
    Statsd.increment("user_registered")
    :ok
  end
end
