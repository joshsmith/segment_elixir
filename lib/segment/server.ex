defmodule Segment.Server do
  @moduledoc """
  Provides the api for sending data to Segment.io.

  All functions are implemented as Genserver casts so that they are out-of-band
  for clients.
  """

  use GenServer
  alias Segment.Http
  alias Segment.{Track, Identify, Screen, Alias, Group, Page, Context}

  require Logger

  @impl true
  def init(config) do
    Logger.log(:debug, "Segment.Server: Started!")
    {:ok, %{config: config}}
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, [name: __MODULE__])
  end

  def track(t = %Track{}) do
    GenServer.cast(__MODULE__, t)
  end

  def track(user_id, event, properties \\ %{}, context \\ Context.new()) do
    t = %Track{userId: user_id, event: event, properties: properties, context: context}
    track(t)
  end

  def identify(i = %Identify{}) do
    GenServer.cast(__MODULE__, i)
  end

  def identify(user_id, traits \\ %{}, context \\ Context.new()) do
    i = %Identify{userId: user_id, traits: traits, context: context}
    identify(i)
  end

  def screen(s = %Screen{}) do
    GenServer.cast(__MODULE__, s)
  end

  def screen(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    s = %Screen{userId: user_id, name: name, properties: properties, context: context}
    screen(s)
  end

  def alias_user(a = %Alias{}) do
    GenServer.cast(__MODULE__, a)
  end

  def alias_user(previous_id, user_id, context \\ Context.new()) do
    a = %Alias{userId: user_id, previousId: previous_id, context: context}
    alias_user(a)
  end

  def group(g = %Group{}) do
    GenServer.cast(__MODULE__, g)
  end

  def group(user_id, group_id, traits \\ %{}, context \\ Context.new()) do
    g = %Group{userId: user_id, groupId: group_id, traits: traits, context: context}
    group(g)
  end

  def page(p = %Page{}) do
    GenServer.cast(__MODULE__, p)
  end

  def page(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    p = %Page{userId: user_id, name: name, properties: properties, context: context}
    page(p)
  end

  @impl true
  def handle_cast(%Track{} = t, state) do
    resp = Http.post!(t.method, Jason.encode!(t))
    Logger.debug fn -> "#{inspect resp}" end
    {:noreply, state}
  end

  def handle_cast(%Identify{} = i, state) do
    resp = Http.post!(i.method, Jason.encode!(i))
    Logger.debug fn -> "#{inspect resp}" end
    {:noreply, state}
  end

  def handle_cast(%Screen{} = s, state) do
    resp = Http.post!(s.method, Jason.encode!(s))
    Logger.debug fn -> "#{inspect resp}" end
    {:noreply, state}
  end

  def handle_cast(%Alias{} = a, state) do
    resp = Http.post!(a.method, Jason.encode!(a))
    Logger.debug fn -> "#{inspect resp}" end
    {:noreply, state}
  end

  def handle_cast(%Group{} = g, state) do
    resp = Http.post!(g.method, Jason.encode!(g))
    Logger.debug fn -> "#{inspect resp}" end
    {:noreply, state}
  end

  def handle_cast(%Page{} = p, state) do
    resp = Http.post!(p.method, Jason.encode!(p))
    Logger.debug fn -> "#{inspect resp}" end
    {:noreply, state}
  end
end
