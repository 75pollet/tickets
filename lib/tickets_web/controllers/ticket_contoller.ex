defmodule TicketsWeb.TicketController do
  use TicketsWeb, :controller
  alias Tickets.Promocode

  def create(conn, %{"number_of_tickets" => _number} = params) do
    case Promocode.generate_event_tickets(params) do
      {:ok, _tickets} -> conn |> put_status(:created) |> render("create.json", success: true)
      _ -> conn |> put_status(:unprocessable_entry) |> render("error.json", success: false)
    end
  end

  def index(conn, _params) do
    all_promocodes = Promocode.all_promocodes()
    conn |> put_status(:ok) |> render("all_promocodes.json", all_promocodes: all_promocodes)
  end

  def active(conn, _params) do
    active_promocodes = Promocode.active_promocodes()

    conn
    |> put_status(:ok)
    |> render("active_promocodes.json", active_promocodes: active_promocodes)
  end
end
