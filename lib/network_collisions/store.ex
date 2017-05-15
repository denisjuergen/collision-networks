defmodule NetworkCollisions.Store do
  @moduledoc "An Agent based store"

  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, fn list -> list end)
  end

  def update(list) do
    Agent.update(__MODULE__, fn _ -> list end)
  end

end