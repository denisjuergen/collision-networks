defmodule NetworkTest do
  use ExUnit.Case
  doctest Network

  test "make a new network" do
    assert Network.make('a') == {'a', nil, nil}
  end

  test "include a node to a network" do
    network = Network.make('a')
    assert Network.include(network, 'b') == {'a', nil, {'b', nil, nil}}
  end

  test "include a node to the left side of a network" do
    network = Network.make('c') |> Network.include('b')
    assert network == {'c', {'b', nil, nil}, nil}
  end

  test "include nodes to both sides of a network" do
    network = Network.make('b') |> Network.include('c') |> Network.include('a')
    assert network == {'b', {'a', nil, nil}, {'c', nil, nil}}
  end

  test "include two nodes to the left of a network" do
    network = Network.make('c') |> Network.include('b') |> Network.include('a')
    assert network == {'c', {'b', {'a', nil, nil}, nil}, nil}
  end

  test "a network of [a] contains 'a'" do
    assert Network.make('a') |> Network.contains('a')
  end

  test "a network of [a] does not contains 'z'" do
    assert Network.make('a') |> Network.contains('z') |> Kernel.not
  end

  test "a network of [a, b] contains 'b'" do
    assert Network.make('a') |> Network.include('b') |> Network.contains('b')
  end

  test "a network of [b, a] contains 'b'" do
    assert Network.make('b') |> Network.include('a') |> Network.contains('b')
  end

  test "a network of [b, a] contains 'a'" do
    assert Network.make('b') |> Network.include('a') |> Network.contains('a')
  end

  test "a network of [d, b, a, e, c] contains all" do
    network = Network.make('d')
              |> Network.include('b')
              |> Network.include('a')
              |> Network.include('e')
              |> Network.include('c')

    assert Network.contains(network, 'a')
    assert Network.contains(network, 'b')
    assert Network.contains(network, 'c')
    assert Network.contains(network, 'd')
    assert Network.contains(network, 'e')
  end

  test "union of two simple networks" do
    network_a = Network.make('a')
    network_b = Network.make('b')
    assert Network.union(network_a, network_b) == {'a', nil, {'b', nil, nil}}
  end

  test "union of two basic networks" do
    network_a = Network.make('a') |> Network.include('b')
    network_b = Network.make('c') |> Network.include('d')
    assert Network.union(network_a, network_b) == {'a', nil, {'b', nil, {'c', nil, {'d', nil, nil}}}}
  end

  test "union of two basic networks (inverted)" do
    network_a = Network.make('c') |> Network.include('d')
    network_b = Network.make('a') |> Network.include('b')
    assert Network.union(network_a, network_b) == {'c', {'a', nil, {'b', nil, nil}}, {'d', nil, nil}}
  end

  test "union of a network of [a, b], [c, d] and [e] contains all" do
    network_a = Network.make('a') |> Network.include('b')
    network_b = Network.make('c') |> Network.include('d')
    network_c = Network.make('e')

    network_union = Network.union(network_a, network_b) |> Network.union(network_c)

    assert Network.contains(network_union, 'a')
    assert Network.contains(network_union, 'b')
    assert Network.contains(network_union, 'c')
    assert Network.contains(network_union, 'd')
    assert Network.contains(network_union, 'e')
  end

  test "list of a network nil equals to []" do
    assert Network.list(nil) == []
  end

  test "list of a network of [a, b, c] equals to [a, b, c]" do
    assert Network.make('a') |> Network.include('b') |> Network.include('c') |> Network.list == ['a', 'b', 'c']
  end

  test "list of a network of [c, d, b, a] equals to [a, b, c, d]" do
    list = Network.make('c') |> Network.include('d') |> Network.include('b') |> Network.include('a') |> Network.list
    assert list == ['a', 'b', 'c', 'd']
  end

  test "any of a network of [a, b, c, d, e] returns true for &(&1 == 'e')" do
    network = Network.make('a')
              |> Network.include('b')
              |> Network.include('c')
              |> Network.include('d')
              |> Network.include('e')
    assert Network.any(network, &(&1 == 'e'))
  end

  test "any of a network of [a, b, c] returns false for &(&1 == 'e')" do
    network = Network.make('a') |> Network.include('b') |> Network.include('c')
    assert !Network.any(network, &(&1 == 'e'))
  end

  test "all of a network of [a, b, c, d, e] returns true for &(&1 <= 'e')" do
    network = Network.make('a')
              |> Network.include('b')
              |> Network.include('c')
              |> Network.include('d')
              |> Network.include('e')

    assert Network.all(network, &(&1 <= 'e'))
  end

  test "all of a network of [a, b, c, d, e] returns false for &(&1 <= 'd')" do
    network = Network.make('a')
              |> Network.include('b')
              |> Network.include('c')
              |> Network.include('d')
              |> Network.include('e')

    assert !Network.all(network, &(&1 <= 'd'))
  end

  test "collides of networks [a, b, c] and [c, d, e] returns false" do
    network_a = Network.make('a') |> Network.include('b') |> Network.include('c')
    network_b = Network.make('c') |> Network.include('d') |> Network.include('e')
    assert !Network.collides(network_a, network_b)
  end

  test "collides of networks [a, b] and [c, d, e] returns false" do
    network_a = Network.make('a') |> Network.include('b')
    network_b = Network.make('c') |> Network.include('d') |> Network.include('e')
    assert !Network.collides(network_a, network_b)
  end

  test "collides of networks [a, b] and nil returns true" do
    network_a = Network.make('a') |> Network.include('b')
    network_b = nil
    assert Network.collides(network_a, network_b)
  end

  test "collides of networks nil and [c, d, e] returns false" do
    network_a = nil
    network_b = Network.make('c') |> Network.include('d') |> Network.include('e')
    assert !Network.collides(network_a, network_b)
  end

  test "intersects of networks [a, b, c] and [c] returns true" do
    network_a = Network.make('a') |> Network.include('b') |> Network.include('c')
    network_b = Network.make('c')
    assert Network.intersects(network_a, network_b)
  end

  test "intersects of networks [a] and [a, b] returns true" do
    network_a = Network.make('a')
    network_b = Network.make('a') |> Network.include('b')
    assert Network.intersects(network_a, network_b)
  end

  test "intersects of networks [a, b, c] and nil returns false" do
    network_a = Network.make('a') |> Network.include('b') |> Network.include('c')
    network_b = nil
    assert !Network.intersects(network_a, network_b)
  end
end