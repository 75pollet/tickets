defmodule Tickets.Promocode.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :amount, :float
    field :date, :date
    field :expired, :boolean, default: false
    field :number_of_tickets, :float, virtual: true
    field :number_of_rides, :integer, default: 1
    field :radius, :float
    field :status, :string, default: "active"
    field :venue, :string
    field :promocode, :string

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [
      :amount,
      :venue,
      :number_of_rides,
      :date,
      :radius,
      :expired,
      :status,
      :promocode
    ])
    |> validate_required([:amount, :venue, :date, :radius, :expired, :status])
    |> put_change(:promocode, UUID.uuid1())
  end
end
