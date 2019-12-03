defmodule Tickets.Promocode do
  @moduledoc """
  this is the promocode context where the logic related to promocodes and tickets are done
  """
  alias Tickets.Promocode.Ticket
  alias Tickets.Repo


  @doc """
  create_ticket/1 creates a single ticket in the database
  """
  @spec create_ticket(map()) :: %Ticket{}
  def create_ticket(attrs) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  generate_event_tickets/1 generates the number of tickets specified by the user
  """
  @spec generate_event_tickets(map()) :: [%Ticket{}, ...]
  def generate_event_tickets(%{"number_of_tickets" => number} = attr) do
    Enum.map(1..number, fn _n ->
      create_ticket(attr)
    end)
  end
end
