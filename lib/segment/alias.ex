defmodule Segment.Alias do
  @derive Jason.Encoder
  @method "alias"

  defstruct [:userId, :previousId, :context, :timestamp, :integrations, method: @method]
end
