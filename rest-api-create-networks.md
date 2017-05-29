# REST API Documentation

## Index
- [List networks](rest-api-list-networks.md)
- [Create networks](rest-api-create-networks.md)
- [Check for collisions](rest-api-check-collisions.md)
- [Check for intersections](rest-api-check-intersections.md)

---

## Create a new network

Creates a new network from 1 to _N_ nodes, being _N_ limited to the network restrictions on the post data size.

#### Definition

```http
POST /api/networks/

nodes[]=aaa&nodes[]=bbb&nodes[]=ccc
```

#### Example request

```bash
curl -X POST \
     -d nodes[]=aaa \
     -d nodes[]=bbb \
     -d nodes[]=ccc \
     -H "Accept: application/json" \
     "http://localhost:4000/api/networks"
```

#### Example response (success)

Returns a list of all existing networks after inserting the specified network.

```raw
HEADERS
    HTTP/1.1 200 OK
    server: Cowboy
    date: Mon, 29 May 2017 18:01:53 GMT
    content-length: 181
    content-type: application/json; charset=utf-8
    cache-control: max-age=0, private, must-revalidate
    x-request-id: 97o0tprludhig2na07uuksn8ugpsd4u6

BODY
    [
        ["anwr", "jxod", "cuxv", "kldh"],
        ["ehnj", "hazt", "rdkz"],
        ["vrpj", "yskq", "zodm"],
        ["axkc", "osfm"],
        ["idwr", "qlow", "eotw", "sgrl"],
        ["mwsb", "ztvm"],
        ["aaa", "bbb", "ccc"]
    ]
```

#### Example response (failure)

A markdown formatted message with the error description and detailed information about the exception.

```raw
HEADERS
    HTTP/1.1 400 Bad Request
    server: Cowboy
    date: Mon, 29 May 2017 18:04:03 GMT
    content-length: 3185
    cache-control: max-age=0, private, must-revalidate
    x-request-id: rst8emfaflka8r29digqkv0jjce7deqh
    content-type: text/markdown; charset=utf-8

BODY
    # Phoenix.ActionClauseError at POST /api/networks
    
    Exception:
    
        ** (Phoenix.ActionClauseError) bad request to NetworkCollisions.NetworksController.update, no matching action clause to process request
            (network_collisions) web/controllers/network_controller.ex:10: NetworkCollisions.NetworksController.update(%Plug.Conn{adapter: {Plug.Adapters.Cowboy.Conn, :...}, assigns: %{}, before_send: [#Function<1.7947973/1 in Plug.Logger.call/2>], body_params: %{}, cookies: %Plug.Conn.Unfetched{aspect: :cookies}, halted: false, host: "localhost", method: "POST", owner: #PID<0.382.0>, params: %{}, path_info: ["api", "networks"], path_params: %{}, peer: {{127, 0, 0, 1}, 35873}, port: 4000, private: %{NetworkCollisions.Router => {[], %{}}, :phoenix_action => :update, :phoenix_controller => NetworkCollisions.NetworksController, :phoenix_endpoint => NetworkCollisions.Endpoint, :phoenix_format => "json", :phoenix_layout => {NetworkCollisions.LayoutView, :app}, :phoenix_pipelines => [:api], :phoenix_route => #Function<1.10462665/1 in NetworkCollisions.Router.match_route/4>, :phoenix_router => NetworkCollisions.Router, :phoenix_view => NetworkCollisions.NetworksView, :plug_session_fetch => #Function<1.131660147/1 in Plug.Session.fetch_session/1>}, query_params: %{}, query_string: "", remote_ip: {127, 0, 0, 1}, req_cookies: %Plug.Conn.Unfetched{aspect: :cookies}, req_headers: [{"user-agent", "curl/7.38.0"}, {"host", "localhost:4000"}, {"accept", "application/json"}], request_path: "/api/networks", resp_body: nil, resp_cookies: %{}, resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}, {"x-request-id", "rst8emfaflka8r29digqkv0jjce7deqh"}], scheme: :http, script_name: [], secret_key_base: "G3+4YVV3Ffau7I8aIjALLhqqFEV5DuW1QvU9aIs2FEsnGPT9ergolIJf020ZhcUL", state: :unset, status: nil}, %{})
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
    
      * URI: http://localhost:4000/api/networks
      * Query string: 
      * Peer: 127.0.0.1:35873
    
    ### Headers
      
      * accept: application/json
      * host: localhost:4000
      * user-agent: curl/7.38.0
    
    ### Session
    
        %{}
```