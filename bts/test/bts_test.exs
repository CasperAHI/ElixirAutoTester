defmodule BTSTest do
  use ExUnit.Case
  doctest BTS

  test "greets the world" do
    assert BTS.hello() == :world1
  end

  test "plus function" do
      assert BTS.muu(1,2,3) == 6
  end
end
