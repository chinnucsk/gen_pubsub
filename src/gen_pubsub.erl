-module(gen_pubsub).

-export([publish/2, subscribe/2, notify/3, request/3]).

publish(EventClass, EventClassId) ->
    gproc:add_local_name({EventClass, EventClassId}).

subscribe(EventClass, EventClassId) ->
    gproc:add_local_property({EventClass, EventClassId}, undefined).

notify(EventClass, EventClassId, Event) ->
    Name = {EventClass, EventClassId},
    gproc:send({p,l,Name}, {'$gen_pubsub_notify', Name, Event}).

request(EventClass, EventClassId, Event) ->
    Name = {EventClass, EventClassId},
    gproc:send({n,l,Name}, {'$gen_pubsub_request', Name, Event}).

