defmodule TicketsWeb.TicketController do
  use TicketsWeb, :controller
  alias Tickets.Promocode

  def create(conn, %{"number_of_tickets" => _number} = params) do
    case Promocode.generate_event_tickets(params) do
      {:ok, _tickets} -> render(conn, "create.json", success: true)
      _ -> render(conn, "error.json", success: false)
    end
  end
end
