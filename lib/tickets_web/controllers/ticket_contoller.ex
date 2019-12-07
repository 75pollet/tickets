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

  def check(conn, %{"distance_from_venue" => _distance, "promocode" => _promocode} = params) do
    case Promocode.promocode_valid?(params) do
      true ->
        conn
        |> put_status(:ok)
        |> render("validity.json", valid: "true")

      false ->
        conn
        |> put_status(:ok)
        |> render("validity.json", valid: "false")

      nil ->
        conn
        |> put_status(:ok)
        |> render("validity.json", valid: "false", reason: "promocode doesn't exist")
    end
  end

  def check(conn, _params) do
    conn
    |> put_status(422)
    |> render("validity.json", valid: "false", reason: "wrong arguments given")
  end
end
