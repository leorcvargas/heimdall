# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :heimdall,
  ecto_repos: [Heimdall.Repo]

# Configures the endpoint
config :heimdall, HeimdallWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lpFhOCLY6xt3SaugqKsPsCJLrmZh8yO9OufJgtRGBPGZZZy+Y/ONKqpWc+kbZwXF",
  render_errors: [view: HeimdallWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Heimdall.PubSub,
  live_view: [signing_salt: "HC6cBf/Q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
