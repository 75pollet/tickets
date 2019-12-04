defmodule TicketsWeb.TicketController do
  use TicketsWeb, :controller
  alias Tickets.Promocode

  def create(conn, %{"number_of_tickets" => _number} = params) do
    case Promocode.generate_event_tickets(params) do
      {:ok, _tickets} -> conn |> put_status(:created) |> render("create.json", success: true)
      _ -> conn |> put_status(:unprocessable_entry) |> render("error.json", success: false)
    end
  end
end
