defmodule Tickets.TicketTest do
  use ExUnit.Case, async: true
  use Tickets.DataCase

  alias Tickets.Promocode
  alias Tickets.Promocode.Ticket

  setup do
    ticket_attrs = %{
      "amount" => 50.0,
      "venue" => "kisumu hotel",
      "date" => "2015-01-23",
      "radius" => 50,
      "status" => "active"
    }

    [attrs: ticket_attrs]
  end

  test "create_ticket/1 creates tickets with unique promo codes", %{attrs: attrs} do
    %Ticket{amount: 50.0} = Promocode.create_ticket(attrs)
  end

  test "generate_event_tickets/1 creates as many tickets as specified by the user", %{
    attrs: attrs
  } do
    {:ok, tickets} =
      attrs |> Map.put("number_of_tickets", 5) |> Promocode.generate_event_tickets()

    assert 5 == Enum.count(tickets)
  end

  test "each ticket created has a unique promocode", %{attrs: attrs} do
    {:ok, [ticket1 | [ticket2]]} =
      attrs |> Map.put("number_of_tickets", 2) |> Promocode.generate_event_tickets()

    refute ticket1.promocode == ticket2.promocode
  end

  test "all_promocodes/0 returns a list of all promocodes", %{attrs: attrs} do
    attrs |> Map.put("number_of_tickets", 6) |> Promocode.generate_event_tickets()

    [_h | _t] = Promocode.all_promocodes()

    assert 6 == Promocode.all_promocodes() |> Enum.count()
  end

  test "active_promocodes/0 returns a list of active promocodes", %{attrs: attrs} do
    attrs |> Map.put("number_of_tickets", 6) |> Promocode.generate_event_tickets()

    %{attrs | "status" => "inactive"}
    |> Map.put("number_of_tickets", 4)
    |> Promocode.generate_event_tickets()

    [_h | _t] = Promocode.active_promocodes()

    assert 6 == Promocode.active_promocodes() |> Enum.count()
    refute 10 == Promocode.active_promocodes() |> Enum.count()
  end

  test "promocode_valid?/1 checks if a promocode is valid", %{attrs: attrs} do
    ticket = attrs |> Promocode.create_ticket()

    assert true ==
             Promocode.promocode_valid?(%{
               "distance_from_venue" => 30,
               "promocode" => ticket.promocode
             })

    refute false ==
             Promocode.promocode_valid?(%{
               "distance_from_venue" => 30,
               "promocode" => ticket.promocode
             })

    assert false ==
             Promocode.promocode_valid?(%{
               "distance_from_venue" => 80,
               "promocode" => ticket.promocode
             })

    refute true ==
             Promocode.promocode_valid?(%{
               "distance_from_venue" => 80,
               "promocode" => ticket.promocode
             })
  end

  test "promocode can be deactivated", %{attrs: attrs} do
    ticket = attrs |> Promocode.create_ticket()

    Promocode.deactivate_ticket(ticket.promocode)

    ticket = Repo.get_by(Ticket, promocode: ticket.promocode)

    refute "active" == ticket.status
    assert "inactive" == ticket.status
  end
end
