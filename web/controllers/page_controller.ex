defmodule Place.PageController do
  use Place.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
