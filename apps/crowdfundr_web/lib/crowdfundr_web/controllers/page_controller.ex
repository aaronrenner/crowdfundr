defmodule CrowdfundrWeb.PageController do
  use CrowdfundrWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
