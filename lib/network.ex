defmodule Network do

  @moduledoc """
  Provides mechanisms to create, expand, test and unify networks
  """

  def make(item) do
    {item, nil, nil}
  end

  def include(nil, item) do
    make(item)
  end

  def include({node, left, right}, item) do
    cond do
      item < node -> {node, include(left, item), right}
      item > node -> {node, left, include(right, item)}
      true -> {node, left, right}
    end
  end

  def contains(nil, _) do
    false
  end

  def contains({node, left, right}, item) do
    cond do
      item < node -> contains(left, item)
      item > node -> contains(right, item)
      true -> item === node
    end
  end

  def union(network, nil) do
    network
  end

  def union(network, {node, left, right}) do
    include(network, node) |> union(right) |> union(left)
  end

  def any(nil, _) do
    false
  end

  def any({node, left, right}, callback) do
    callback.(node) || any(left, callback) || any(right, callback)
  end

  def all(nil, _) do
    true
  end

  def all({node, left, right}, callback) do
    callback.(node) && all(left, callback) && all(right, callback)
  end

  def intersects(network_a, network_b) do
    any(network_a, &contains(network_b, &1))
  end

  def collides(network_a, network_b) do
    all(network_b, &contains(network_a, &1))
  end

  def list(nil) do
    []
  end

  def list({node, left, right}) do
    list(left) ++ [node] ++ list(right)
  end
end