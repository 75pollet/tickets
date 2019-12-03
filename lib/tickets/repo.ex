defmodule Tickets.Repo do
  use Ecto.Repo,
    otp_app: :tickets,
    adapter: Ecto.Adapters.Postgres
end
