# REST API Documentation

## Index
- [List networks](rest-api-list-networks.md)
- [Create networks](rest-api-create-networks.md)
- [Check for collisions](rest-api-check-collisions.md)
- [Check for intersections](rest-api-check-intersections.md)

---

## Check for an intersection with a specific network

Indicates if any part of the specified network intersects with any network currently existing in the endpoint.

#### Definition

```http
GET /api/networks/intersects?nodes[]=zzz&nodes[]=aaa
```

#### Example request

```bash
curl -X GET \
     -H "Accept: application/json" \
     -d nodes[]=zzz \
     -d nodes[]=aaa \
     -G "http://localhost:4000/api/networks/intersects"
```

#### Example response (success)

Returns a Boolean indicating whether the intersection occurred or not.

```raw
HEADERS
    HTTP/1.1 200 OK
    server: Cowboy
    date: Mon, 29 May 2017 18:19:25 GMT
    content-length: 5
    content-type: application/json; charset=utf-8
    cache-control: max-age=0, private, must-revalidate
    x-request-id: u82vetru0jj7eg7c0khct3e8qur4gbiv

BODY
    true
```

#### Example response (failure)

A markdown formatted message with the error description and detailed information about the exception.

```raw
HEADERS
    HTTP/1.1 200 OK
    server: Cowboy
    date: Mon, 29 May 2017 18:19:25 GMT
    content-length: 5
    content-type: application/json; charset=utf-8
    cache-control: max-age=0, private, must-revalidate
    x-request-id: u82vetru0jj7eg7c0khct3e8qur4gbiv
    
BODY
    # Phoenix.ActionClauseError at GET /api/networks/intersects
    
    Exception:
    
        ** (Phoenix.ActionClauseError) bad request to NetworkCollisions.NetworksController.intersects, no matching action clause to process request
            (network_collisions) web/controllers/network_controller.ex:22: NetworkCollisions.NetworksController.intersects(%Plug.Conn{adapter: {Plug.Adapters.Cowboy.Conn, :...}, assigns: %{}, before_send: [#Function<1.7947973/1 in Plug.Logger.call/2>], body_params: %{}, cookies: %Plug.Conn.Unfetched{aspect: :cookies}, halted: false, host: "localhost", method: "GET", owner: #PID<0.403.0>, params: %{}, path_info: ["api", "networks", "intersects"], path_params: %{}, peer: {{127, 0, 0, 1}, 35998}, port: 4000, private: %{NetworkCollisions.Router => {[], %{}}, :phoenix_action => :intersects, :phoenix_controller => NetworkCollisions.NetworksController, :phoenix_endpoint => NetworkCollisions.Endpoint, :phoenix_format => "json", :phoenix_layout => {NetworkCollisions.LayoutView, :app}, :phoenix_pipelines => [:api], :phoenix_route => #Function<3.10462665/1 in NetworkCollisions.Router.match_route/4>, :phoenix_router => NetworkCollisions.Router, :phoenix_view => NetworkCollisions.NetworksView, :plug_session_fetch => #Function<1.131660147/1 in Plug.Session.fetch_session/1>}, query_params: %{}, query_string: "", remote_ip: {127, 0, 0, 1}, req_cookies: %Plug.Conn.Unfetched{aspect: :cookies}, req_headers: [{"user-agent", "curl/7.38.0"}, {"host", "localhost:4000"}, {"accept", "application/json"}], request_path: "/api/networks/intersects", resp_body: nil, resp_cookies: %{}, resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}, {"x-request-id", "ud59v5d5vuqf8qcgm569cgmcrlhc4l8a"}], scheme: :http, script_name: [], secret_key_base: "G3+4YVV3Ffau7I8aIjALLhqqFEV5DuW1QvU9aIs2FEsnGPT9ergolIJf020ZhcUL", state: :unset, status: nil}, %{})
            (network_collisions) web/controllers/network_controller.ex:1: NetworkCollisions.NetworksController.action/2
            (network_collisions) web/controllers/network_controller.ex:1: NetworkCollisions.NetworksController.phoenix_controller_pipeline/2
            (network_collisions) lib/network_collisions/endpoint.ex:1: NetworkCollisions.Endpoint.instrument/4
            (network_collisions) lib/phoenix/router.ex:261: NetworkCollisions.Router.dispatch/2
            (network_collisions) web/router.ex:1: NetworkCollisions.Router.do_call/2
            (network_collisions) lib/network_collisions/endpoint.ex:1: NetworkCollisions.Endpoint.phoenix_pipeline/1
            (network_collisions) lib/plug/debugger.ex:123: NetworkCollisions.Endpoint."call (overridable 3)"/2
            (network_collisions) lib/network_collisions/endpoint.ex:1: NetworkCollisions.Endpoint.call/2
            (plug) lib/plug/adapters/cowboy/handler.ex:15: Plug.Adapters.Cowboy.Handler.upgrade/4
            (cowboy) /home/denisbrat/Projects/Elixir/network_collisions/deps/cowboy/src/cowboy_protocol.erl:442: :cowboy_protocol.execute/4
        
    
    ## Connection details
    
    ### Params
    
        %{}
    
    ### Request info
    
      * URI: http://localhost:4000/api/networks/intersects
      * Query string: 
      * Peer: 127.0.0.1:35998
    
    ### Headers
      
      * accept: application/json
      * host: localhost:4000
      * user-agent: curl/7.38.0
    
    ### Session
    
        %{}
```