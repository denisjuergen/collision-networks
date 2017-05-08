defmodule NetworkSetTest do
  use ExUnit.Case
  doctest NetworkSet

  @network_abc Network.make('a') |> Network.include('b') |> Network.include('c')
  @network_def Network.make('d') |> Network.include('e') |> Network.include('f')
  @network_cde Network.make('c') |> Network.include('d') |> Network.include('e')
  @network_abcde Network.union(@network_abc, @network_cde)
  @network_abcdef Network.union(@network_abcde, @network_def)

  @network_hij Network.make('h') |> Network.include('i') |> Network.include('j')
  @network_klm Network.make('k') |> Network.include('l') |> Network.include('m')
  @network_nop Network.make('n') |> Network.include('o') |> Network.include('p')
  @network_hlp Network.make('h') |> Network.include('l') |> Network.include('p')

  @network_hijklmnop Network.union(@network_hij, @network_klm)
                     |> Network.union(@network_nop)
                     |> Network.union(@network_hlp)

  test "create a network set from nil" do
    assert NetworkSet.make(nil) == []
  end

  test "create a network set from a network [a]" do
    assert Network.make('a') |> NetworkSet.make == [{'a', nil, nil}]
  end

  test "create a network set from a network [a, b, c]" do
    assert NetworkSet.make(@network_abc) == [@network_abc]
  end

  test "create a network set from networks [a, b, c] and [d, e, f]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_def) == [@network_def, @network_abc]
  end

  test "create a network set from networks [a, b, c] and [c, d, e]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_cde) == [@network_abcde]
  end

  test "create an optimized network set from networks [a, b, c], [c, d, e] and [d, e, f]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_cde) |> NetworkSet.append(@network_def) == [@network_abcdef]
  end

  test "create an optimized network set from networks [h, i, j], [k, l, m], [n, o, p] and [h, l, p]" do
    set = NetworkSet.make(@network_hij)
          |> NetworkSet.append(@network_klm)
          |> NetworkSet.append(@network_nop)
          |> NetworkSet.append(@network_hlp)

    assert set == [@network_hijklmnop]
  end

  test "search a network set from networks [a, b, c] and [d, e, f] for network [e]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_def) |> NetworkSet.contains({'e', nil, nil})
  end

  test "search a network set from networks [a, b, c] and [d, e, f] for network [a, f]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_def) |> NetworkSet.contains({'a', nil, {'f', nil, nil}}) |> Kernel.not
  end

  test "search an optimized network set from networks [a, b, c] and [c, d, e] for network [c]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_cde) |> NetworkSet.contains({'c', nil, nil})
  end

  test "search an optimized network set from networks [a, b, c] and [c, d, e] for network [c, d]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_cde) |> NetworkSet.contains({'c', nil, {'d', nil, nil}})
  end

  test "search an optimized network set from networks [a, b, c] and [c, d, e] for network [a, f, g]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_cde) |> NetworkSet.contains({'a', nil, {'f', nil, {'g', nil, nil}}}) |> Kernel.not
  end

  test "search a network set from networks [a, b, c] and [d, e, f] for any node in network [a, f]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_def) |> NetworkSet.containsAny({'a', nil, {'f', nil, nil}})
  end

  test "search an optimized network set from networks [a, b, c] and [c, d, e] for any node in network [a, f, g]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_cde) |> NetworkSet.containsAny({'a', nil, {'f', nil, {'g', nil, nil}}})
  end

  test "search an optimized network set from networks [a, b, c] and [c, d, e] for any node in network [h, i, j]" do
    assert NetworkSet.make(@network_abc) |> NetworkSet.append(@network_cde) |> NetworkSet.containsAny({'h', nil, {'i', nil, {'j', nil, nil}}}) |> Kernel.not
  end
  
end