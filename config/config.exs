# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :place,
  ecto_repos: [Place.Repo]

# Configures the endpoint
config :place, Place.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tqrleCAQmqi63HgQiiFM8LJool4/whLPJgA1g41PQkPUbwKt5DB/v/6ZTqwrYRYK",
  render_errors: [view: Place.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Place.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
