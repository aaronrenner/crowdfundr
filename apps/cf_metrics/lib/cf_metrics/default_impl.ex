defmodule CFMetrics.DefaultImpl do
  @moduledoc false

  alias CFMetrics.DefaultImpl.Statsd

  @behaviour CFMetrics.Impl

  @impl true
  @spec send_user_registered :: :ok
  def send_user_registered do
    Statsd.increment("user_registered")
    :ok
  end
end
