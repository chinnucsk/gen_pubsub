-module(gen_pubsub_test).

-compile([export_all]).

-include_lib("eunit/include/eunit.hrl").
-include_lib("hoax/include/hoax.hrl").

?HOAX_FIXTURE.

publish_should_register_gproc_local_name() ->
    mock(gproc, [
            {add_local_name, [{user_name, "jon.doe"}]}
        ]),

    gen_pubsub:publish(user_name, "jon.doe"),

    ?verifyAll.

subscribe_should_register_gproc_local_property() ->
    mock(gproc, [
            {add_local_property, [{topic, "erlang"}, undefined]}
        ]),

    gen_pubsub:subscribe(topic, "erlang"),

    ?verifyAll.

notify_should_send_to_gproc_local_property() ->
    mock(gproc, [
            {send, [
                    {p,l,{topic, "erlang"}},
                    {'$gen_pubsub_notify', {topic, "erlang"}, event}
                ]}
        ]),

    gen_pubsub:notify(topic, "erlang", event),

    ?verifyAll.

request_should_send_to_gproc_local_name() ->
    mock(gproc, [
            {send, [
                    {n,l,{user_name, "jon.doe"}},
                    {'$gen_pubsub_request', {user_name, "jon.doe"}, event}
                ]}
        ]),

    gen_pubsub:request(user_name, "jon.doe", event),

    ?verifyAll.
