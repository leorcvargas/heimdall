alias Heimdall.Accounts
alias Heimdall.Monitors

defmodule HeimdallSeeds do
  def seed_user! do
    user_attrs = %{
      email: "dev@heimdall.com",
      password: "super_amazing_password"
    }

    case Accounts.register_user(user_attrs) do
      {:ok, user} ->
        user

      {:error, _} ->
        raise "Failed to seed user"
    end
  end

  def seed_monitors!(user) do
    monitors = [
      %{name: "leovargas personal site", url: "https://leovargas.dev", reference_id: "31ADwqe2"},
      %{name: "pudim", url: "https://pudim.com.br", reference_id: "pud1m"},
      %{name: "Martin Fowler site", url: "https://martinfowler.com", reference_id: "EQWd123e"},
      %{
        name: "Totally invalid",
        url: "https://do-you-really-think-this-site-exist.com",
        reference_id: "e1defqswae"
      },
      %{name: "Twitter", url: "https://twitter.com", reference_id: "tw1tt3r_ewq3123"}
    ]

    Enum.map(monitors, fn data ->
      case Monitors.create_monitor(data, user) do
        {:ok, monitor} ->
          monitor

        {:error, _} ->
          raise "Failed to seed monitor"
      end
    end)
  end

  def main! do
    seed_user!()
    |> seed_monitors!()
  end
end

HeimdallSeeds.main!()
