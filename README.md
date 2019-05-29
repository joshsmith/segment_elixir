segment_elixir
================

segment_elixir is a non-supported third-party client for [Segment](https://segment.com)

## Installation

In `mix.exs`, add the `segment_elixir` dependency:

```elixir
def deps do
  # Get the latest from hex.pm.
  [
    {:segment_elixir, "~> 2.0"},
  ]
end
```

And then run `mix deps.get` to install it.

Add the following configuration to your `config.ex`:

```elixir
config :segment, write_key: "2iFFnRsCfi"
```

In tests, you can set the configuration to use the sandbox:

```elixir
# config/test.exs
config :segment, api: Segment.Sandbox
```

Make sure you reset the sandbox state between tests. 
If you're using Phoenix this is as easy as adding:

```elixir
# test/support/conn_case.ex
setup tags
  :ok = Segment.Sandbox.checkout()
  ...
end
```

## Usage

Configure Segment with your write_key
```
config :segment, write_key: System.get_env("SEGMENT_WRITE_KEY")
```

You can call the different methods on the API (like `track`, `identify`, etc.) either by:

1. Passing in arguments, or:
2. Passing a full struct (which allows you to set Context and Integrations)

### `track`

```elixir
Segment.track(user_id, event, %{property1: "", property2: ""})
```

or the full way using a struct with all the possible options for the track call

```elixir
%Segment.Track{
  userId: "foo",
  vent: "eventname",
                          properties: %{property1: "", property2: ""}
 }
 > Segment.track
```

### `identify`

```elixir
Segment.identify(user_id, %{trait1: "", trait2: ""})
```

or the full way using a struct with all the possible options for the identify call

```elixir
%Segment.Identify{
  userId: "foo",
  %{
    trait1: "",
    trait2: ""
  }
}
|> Segment.identify
```

### `screen`

```elixir
Segment.screen(user_id, name)
```

or the full way using a struct with all the possible options for the screen call

```elixir
%Segment.Screen{
  userId: "foo",
  name: "bar"
}
|> Segment.screen
```

### `alias`

> Note that we need to use `alias_user` here instead of Segment's `alias`, due to `alias` being reserved in Elixir.

```elixir
Segment.alias_user(user_id, previous_id)
```

or the full way using a struct with all the possible options for the alias call:

```elixir
%Segment.Alias{
  userId: "foo",
  previousId: "bar"
}
|> Segment.alias_user
```

### `group`

```elixir
Segment.group(user_id, group_id)
```

or the full way using a struct with all the possible options for the group call

```elixir
%Segment.Group{
  userId: "foo",
  groupId: "bar"
}
|> Segment.group
```

### `page`

```elixir
Segment.page(user_id, name)
```

or the full way using a struct with all the possible options for the page call

```elixir
%Segment.Page{
  userId: "foo",
  name: "bar"
}
|> Segment.page
```

## Usage in tests

Sandbox keeps track of events that occured since the last `Segment.Sandbox.checkout()` call.
They can be accessed by following functions from `Segment.Sandbox` module:
* `get_track_calls/0`
* `get_identify_calls/0`
* `get_screen_calls/0`
* `get_alias_calls/0`
* `get_group_calls/0`
* `get_group_calls/0`

Example usage:
```elixir
tracked_events = Segment.Sandbox.get_track_calls() |> Enum.map(& &1.event)
assert "Trial Started" in tracked_events
assert length(tracked_events) == 1
```

## Running tests

There are not many tests at the moment. But you can run a live test on your segment account by running:

```elixir
SEGMENT_KEY=yourkey mix test
```

## Acknowledgements

This is a fork from stueccles' [analytics-elixir](https://github.com/stueccles/analytics-elixir) incorporating work done by lswith [in his fork](https://github.com/lswith/analytics-elixir).
