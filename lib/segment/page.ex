defmodule Segment.Page do
  @derive Jason.Encoder
  @method "page"

  defstruct [
    :userId,
    :name,
    :properties,
    :context,
    :timestamp,
    :integrations,
    :anonymousId,
    method: @method
  ]
end
