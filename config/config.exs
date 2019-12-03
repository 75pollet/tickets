# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tickets,
  ecto_repos: [Tickets.Repo]

# Configures the endpoint
config :tickets, TicketsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iN68jFjdvt9efE3+prFwd6FO9r772Ls4CyJPr3kCNElAREGqajIPwT/crxsZotSF",
  render_errors: [view: TicketsWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: Tickets.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
