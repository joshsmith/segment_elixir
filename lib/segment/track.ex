defmodule Segment.Track do
  @derive Jason.Encoder
  @method "track"

  defstruct [
    :userId,
    :event,
    :properties,
    :context,
    :timestamp,
    :integrations,
    :anonymousId,
    method: @method
  ]
end
