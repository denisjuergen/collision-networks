defmodule NetworkCollisions.NetworksController do
  use NetworkCollisions.Web, :controller

  @moduledoc false

  def index(conn, _) do
    set = case NetworkCollisions.Store.get do
      [] -> Network.make("a") |> NetworkSet.make
      set -> NetworkSet.append(set, Network.make(?a..?z |> Enum.map(&List.to_string([&1])) |> Enum.random))
    end
    NetworkCollisions.Store.update(set)
    json conn, NetworkSet.flatten(set)
  end
end