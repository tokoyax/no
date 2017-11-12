defmodule NoTest do
  use ExUnit.Case
  doctest No

  test "greets the world" do
    assert No.hello() == :world
  end
end
