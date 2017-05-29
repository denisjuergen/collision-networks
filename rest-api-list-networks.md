# REST API Documentation

## Index
- [List networks](rest-api-list-networks.md)
- [Create networks](rest-api-create-networks.md)
- [Check for collisions](rest-api-check-collisions.md)
- [Check for intersections](rest-api-check-intersections.md)

---

## Fetch existing networks

Returns a list of existing networks.

#### Definition

```http
GET /api/networks/
```

#### Example request

```bash
curl -X GET \
     -H "Accept: application/json" \
     "http://localhost:4000/api/networks"
```

#### Example response (success)

A list of all networks currently available in the endpoint.

```raw
HEADERS
    HTTP/1.1 200 OK
    server: Cowboy
    date: Mon, 29 May 2017 17:40:42 GMT
    content-length: 161
    content-type: application/json; charset=utf-8
    cache-control: max-age=0, private, must-revalidate
    x-request-id: avtt82m85mq39fpm8qhqiii30clvju99
    
BODY
    [
        ["anwr", "jxod", "cuxv", "kldh"],
        ["ehnj", "hazt", "rdkz"],
        ["vrpj", "yskq", "zodm"],
        ["axkc", "osfm"],
        ["idwr", "qlow", "eotw", "sgrl"],
        ["mwsb", "ztvm"]
    ]
```

#### Example response (failure)

A markdown formatted message with the error description and detailed information about the exception.

```raw
HEADERS
    HTTP/1.1 404 Not Found
    server: Cowboy
    date: Mon, 29 May 2017 17:42:41 GMT
    content-length: 1162
    cache-control: max-age=0, private, must-revalidate
    content-type: text/markdown; charset=utf-8

BODY
    # Phoenix.Router.NoRouteError at GET /api/networks1
    
    Exception:
    
        ** (Phoenix.Router.NoRouteError) no route found for GET /api/networks1 (NetworkCollisions.Router)
            (network_collisions) web/router.ex:1: NetworkCollisions.Router.match_route/4
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
    
      * URI: http://localhost:4000/api/networks1
      * Query string: 
      * Peer: 127.0.0.1:35644
    
    ### Headers
      
      * accept: application/json
      * host: localhost:4000
      * user-agent: curl/7.38.0
    
    ### Session
    
        nil
```