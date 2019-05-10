defmodule Segment.Identify do
  @derive Jason.Encoder
  @method "identify"

  defstruct [:userId, :traits, :context, :timestamp, :integrations, :anonymousId, method: @method]
end
