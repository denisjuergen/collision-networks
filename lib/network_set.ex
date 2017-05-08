defmodule NetworkSet do

  @moduledoc """
  Provides a managed network set that supports operations for checking network collisions
  """

  def make(nil) do
    []
  end

  def make(network) do
    [network]
  end

  def append(set, network) do
    make(network) ++ set |> optimize
  end

  defp optimize([head | tail]) do
    {match, remainder} = Enum.split_with(tail, &(Network.collides(&1, head)))
    [Enum.reduce(match, head, &(Network.union/2))] ++ optimize(remainder)
  end

  defp optimize(list) do
    list
  end

  def contains([head | tail], fragment) do
    Network.intersects(head, fragment) || contains(tail, fragment)
  end

  def contains(_, _) do
    false
  end

  def containsAny([head | tail], fragment) do
    Network.collides(head, fragment) || containsAny(tail, fragment)
  end

  def containsAny(_, _) do
    false
  end
end