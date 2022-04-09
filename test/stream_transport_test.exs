defmodule StreamTransportTest do
  use ExUnit.Case
  doctest StreamTransport

  test "greets the world" do
    assert StreamTransport.hello() == :world
  end
end
