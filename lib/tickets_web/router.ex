defmodule TicketsWeb.Router do
  use TicketsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TicketsWeb do
    pipe_through :api

    post "/generate_tickets", TicketController, :create
    get "/promocodes", TicketController, :index
    get "/promocodes/active", TicketController, :active
    get "/promocode/check_validity", TicketController, :check
    put "/promocode/deactivate/:promocode", TicketController, :edit
  end
end
