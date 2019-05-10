defmodule Segment.Group do
  @derive Jason.Encoder
  @method "group"

  defstruct [
    :userId,
    :groupId,
    :traits,
    :context,
    :timestamp,
    :integrations,
    :anonymousId,
    method: @method
  ]
end
