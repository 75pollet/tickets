defmodule TicketsWeb.Router do
  use TicketsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TicketsWeb do
    pipe_through :api

    post "/generate_tickets", TicketController, :create
  end
end
