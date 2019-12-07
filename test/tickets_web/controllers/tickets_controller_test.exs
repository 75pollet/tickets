defmodule Tickets.TicketControllerTest do
  use TicketsWeb.ConnCase
  alias Tickets.Promocode
  alias TicketsWeb.TicketView

  setup do
    attrs = %{
      "amount" => 50,
      "venue" => "kisumu hotel",
      "date" => "2015-01-23",
      "radius" => 50,
      "number_of_tickets" => 50
    }

    [attrs: attrs, ticket: Promocode.create_ticket(attrs)]
  end

  test "create renders codes details", %{conn: conn, attrs: attrs} do
    conn =
      post(
        conn,
        Routes.ticket_path(conn, :create, attrs)
      )

    assert json_response(conn, 201) == render_json(TicketView, "create.json", conn.assigns)
  end

  test "a list of promocodes available can be gotten", %{conn: conn} do
    conn =
      get(
        conn,
        Routes.ticket_path(conn, :index)
      )

    assert json_response(conn, 200) ==
             render_json(TicketView, "all_promocodes.json", conn.assigns)
  end

  test "a list of active promocodes can be gotten", %{conn: conn} do
    conn =
      get(
        conn,
        Routes.ticket_path(conn, :active)
      )

    assert json_response(conn, 200) ==
             render_json(TicketView, "active_promocodes.json", conn.assigns)
  end

  test "the validity of a promocode can be checked given the correct attributes", %{
    conn: conn,
    ticket: ticket
  } do
    conn =
      get(
        conn,
        Routes.ticket_path(conn, :check, %{
          "distance_from_venue" => 40,
          "promocode" => ticket.promocode
        })
      )

    assert json_response(conn, 200) ==
             render_json(TicketView, "validity.json", conn.assigns)
  end

  test "if distance is greater than the promocode radius the promocode is invalid", %{
    conn: conn,
    ticket: ticket
  } do
    conn =
      get(
        conn,
        Routes.ticket_path(conn, :check, %{
          "distance_from_venue" => 70,
          "promocode" => ticket.promocode
        })
      )

    assert json_response(conn, 200) ==
             render_json(TicketView, "validity.json", conn.assigns)
  end

  test "a promocode can be deactivated", %{conn: conn, ticket: ticket} do
    conn =
      put(
        conn,
        "/api/promocode/deactivate/#{ticket.promocode}"
      )

    assert json_response(conn, 200) ==
             render_json(TicketView, "deactivate.json", conn.assigns)
  end

  defp render_json(module, template, assigns) do
    assigns = Map.new(assigns)

    template
    |> module.render(assigns)
    |> Jason.encode!()
    |> Jason.decode!()
  end
end
