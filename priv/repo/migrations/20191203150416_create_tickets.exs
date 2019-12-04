defmodule Tickets.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :amount, :float
      add :venue, :string
      add :date, :date
      add :radius, :float
      add :expired, :boolean, default: false, null: false
      add :number_of_rides, :integer, default: 1
      add :status, :string, default: "active"
      add :promocode, :string, null: false

      timestamps()
    end

  end
end
