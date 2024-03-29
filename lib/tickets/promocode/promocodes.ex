defmodule Tickets.Promocode do
  @moduledoc """
  this is the promocode context where the logic related to promocodes and tickets are done
  """
  alias Tickets.Promocode.Ticket
  alias Tickets.Repo
  import Ecto.Query

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
  def generate_event_tickets(%{"number_of_tickets" => number} = attr) when is_bitstring(number) do
    %{attr | "number_of_tickets" => number |> String.to_integer()} |> generate_event_tickets()
  end

  def generate_event_tickets(%{"number_of_tickets" => number} = attr) do
    Repo.transaction(fn ->
      Enum.map(1..number, fn _n ->
        create_ticket(attr)
      end)
    end)
  end

  @doc """
  returns a list of all promocodes
  """
  @spec all_promocodes :: list()
  def all_promocodes do
    q = from t in Ticket, select: t.promocode
    Repo.all(q)
  end

  @doc """
  returns a list of active promocodes
  """
  @spec active_promocodes :: list()
  def active_promocodes do
    q = from t in Ticket, where: t.status == "active", select: t.promocode
    Repo.all(q)
  end

  @doc """
  checks for the validity of a promocode
  """
  @spec promocode_valid?(map()) :: boolean | nil
  def promocode_valid?(%{"distance_from_venue" => distance, "promocode" => promocode}) do
    case Repo.get_by(Ticket, promocode: promocode) do
      nil -> nil
      code -> code.radius >= distance
    end
  end

  @doc """
  deactivate ticket status
  """
  @spec deactivate_ticket(String.t()) :: {:ok, %Ticket{}} | {:error, Ecto.Changeset.t()} | nil
  def deactivate_ticket(promocode) do
    case Repo.get_by(Ticket, promocode: promocode) do
      nil ->
        nil

      ticket ->
        ticket
        |> Ticket.update_changeset(%{status: "inactive"})
        |> Repo.update!()
    end
  end
end
