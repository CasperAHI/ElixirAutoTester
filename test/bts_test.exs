defmodule BTSTest do
  use ExUnit.Case
  doctest BTS

  test "Testing New function in BTS" do
    assert BTS.new() == {nil, nil, nil}
    assert BTS.new(1) == {1, nil, nil}
    assert BTS.new([5, 2, 9]) == {5, {2, nil, nil}, {9, nil, nil}}
  end

  test "Testing insert function in BTS" do
      assert BTS.insert(1, {nil, nil, nil}) == {1, nil, nil}
      assert BTS.insert(1, {5, nil, nil}) == {5, {1, nil, nil}, nil}
      assert BTS.insert(10, {5, nil, nil}) == {5, nil, {10, nil, nil}}
  end
end
