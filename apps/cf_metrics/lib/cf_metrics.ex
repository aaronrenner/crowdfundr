defmodule CFMetrics do
  @moduledoc """
  Internal API for reporting application metrics.
  """

  import Constantizer

  alias CFMetrics.DefaultImpl

  @behaviour CFMetrics.Impl

  @doc """
  Report a user registered event.
  """
  @impl true
  @spec send_user_registered :: :ok
  def send_user_registered do
    impl().send_user_registered()
  end

  defconstp impl do
    Application.get_env(:cf_metrics, :impl, DefaultImpl)
  end
end
