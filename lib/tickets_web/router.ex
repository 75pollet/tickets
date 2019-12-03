defmodule TicketsWeb.Router do
  use TicketsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TicketsWeb do
    pipe_through :api
  end
end
