defmodule CFMetrics.DefaultImplTest do
  use ExUnit.Case, async: true

  alias CFMetrics.DefaultImpl

  test "returns :ok" do
    assert :ok = DefaultImpl.send_user_registered()
  end
end
