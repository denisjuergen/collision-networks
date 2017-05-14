# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :network_collisions, NetworkCollisions.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G3+4YVV3Ffau7I8aIjALLhqqFEV5DuW1QvU9aIs2FEsnGPT9ergolIJf020ZhcUL",
  render_errors: [view: NetworkCollisions.ErrorView, accepts: ~w(json)],
  pubsub: [name: NetworkCollisions.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
