defmodule Segment do
  @moduledoc """
  Provides the API for sending data to Segment.
  """

  @module Application.get_env(:segment, :api) || Segment.Server

  defdelegate track(t), to: @module
  defdelegate identify(i), to: @module
  defdelegate screen(s), to: @module
  defdelegate alias_user(a), to: @module
  defdelegate group(g), to: @module
  defdelegate page(p), to: @module
end
