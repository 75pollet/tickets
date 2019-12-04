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
      "radius" => 50
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

  test "all_promocodes returns a list of all promocodes", %{attrs: attrs} do
    attrs |> Map.put("number_of_tickets", 6) |> Promocode.generate_event_tickets()

    [_h | _t] = Promocode.all_promocodes()

    assert 6 == Promocode.all_promocodes() |> Enum.count()
  end
end
