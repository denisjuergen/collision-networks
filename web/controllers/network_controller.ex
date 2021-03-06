defmodule NetworkCollisions.NetworksController do
  use NetworkCollisions.Web, :controller

  @moduledoc false

  def index(conn, _) do
    json conn, NetworkCollisions.Store.get |> NetworkSet.flatten
  end

  def update(conn, %{"nodes" => [node | more]}) do
    network = network(node, more)
    updated = NetworkCollisions.Store.get |> NetworkSet.append(network)
    NetworkCollisions.Store.update(updated)
    json conn, NetworkSet.flatten(updated)
  end

  def collides(conn, %{"nodes" => [node | more]}) do
    network = network(node, more)
    json conn, NetworkCollisions.Store.get |> NetworkSet.contains(network)
  end

  def intersects(conn, %{"nodes" => [node | more]}) do
    network = network(node, more)
    json conn, NetworkCollisions.Store.get |> NetworkSet.containsAny(network)
  end

  defp network(node, more) do
    Enum.reduce(more, Network.make(node), &Network.include(&2, &1))
  end
end