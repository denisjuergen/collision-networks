defmodule NetworkCollisions.Router do
  use NetworkCollisions.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NetworkCollisions do
    pipe_through :api

    scope "/networks" do
      get "/", NetworksController, :index
    end
  end
end
