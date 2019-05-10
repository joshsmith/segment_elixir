defmodule Segment.Sandbox do
  @moduledoc """
  Provides an api that can be used in tests to ensure
  data is correctly sent to segment.io.
  """

  alias Segment.{Track, Identify, Screen, Alias, Group, Page, Context}
  use Agent

  def start_link(_args) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def track(t = %Track{}) do
    Agent.update(__MODULE__, &Map.put(&1, "track", t))
  end

  def get_track do
    Agent.get(__MODULE__, &Map.get(&1, "track"))
  end

  def track(user_id, event, properties \\ %{}, context \\ Context.new()) do
    t = %Track{userId: user_id, event: event, properties: properties, context: context}
    track(t)
  end

  def identify(i = %Identify{}) do
    Agent.update(__MODULE__, &Map.put(&1, "identify", i))
  end

  def get_identify do

    Agent.get(__MODULE__, &Map.get(&1, "identify"))
  end

  def identify(user_id, traits \\ %{}, context \\ Context.new()) do
    i = %Identify{userId: user_id, traits: traits, context: context}
    identify(i)
  end

  def screen(s = %Screen{}) do
    Agent.update(__MODULE__, &Map.put(&1, "screen", s))
  end

  def get_screen do

    Agent.get(__MODULE__, &Map.get(&1, "screen"))
  end

  def screen(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    s = %Screen{userId: user_id, name: name, properties: properties, context: context}
    screen(s)
  end

  def alias_user(a = %Alias{}) do
    Agent.update(__MODULE__, &Map.put(&1, "alias", a))
  end

  def get_alias do
    Agent.get(__MODULE__, &Map.get(&1, "alias"))
  end

  def alias_user(user_id, previous_id, context \\ Context.new()) do
    a = %Alias{userId: user_id, previousId: previous_id, context: context}
    alias_user(a)
  end

  def group(g = %Group{}) do
    Agent.update(__MODULE__, &Map.put(&1, "group", g))
  end

  def get_group do
    Agent.get(__MODULE__, &Map.get(&1, "group"))

  end

  def group(user_id, group_id, traits \\ %{}, context \\ Context.new()) do
    g = %Group{userId: user_id, groupId: group_id, traits: traits, context: context}
    group(g)
  end

  def page(p = %Page{}) do
    Agent.update(__MODULE__, &Map.put(&1, "page", p))
  end

  def get_page do
    Agent.get(__MODULE__, &Map.get(&1, "page"))
  end

  def page(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    p = %Page{userId: user_id, name: name, properties: properties, context: context}
    page(p)
  end

end
