defmodule Segment.Context do
  alias __MODULE__

  @derive Jason.Encoder
  @library_name Mix.Project.get().project[:description]
  @library_version Mix.Project.get().project[:version]

  defstruct [
    :active,
    :app,
    :campaign,
    :device,
    :groupId,
    :ip,
    :library,
    :locale,
    :location,
    :network,
    :os,
    :page,
    :referrer,
    :screen,
    :timezone,
    :traits,
    :userAgent
  ]

  def update(context = %Context{}) do
    %{context | library: %{name: @library_name, version: @library_version}}
  end

  def new(attrs \\ %{}) do
    %Context{}
    |> struct(attrs)
    |> update
  end
end
