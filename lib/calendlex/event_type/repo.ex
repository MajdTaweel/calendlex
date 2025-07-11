defmodule Calendlex.EventType.Repo do
  alias Calendlex.{EventType, Repo}
  import Ecto.Query

  def available do
    EventType
    |> where([e], is_nil(e.deleted_at))
    |> order_by([e], e.name)
    |> Repo.all()
  end

  def get_by_slug(slug) do
    case Repo.get_by(EventType, slug: slug) do
      nil ->
        {:error, :not_found}

      event_type ->
        {:ok, event_type}
    end
  end

  def insert(params) do
    params
    |> EventType.changeset()
    |> Repo.insert()
  end

  def get(id) do
    case Repo.get(EventType, id) do
      nil -> {:error, :not_found}
      event_type -> {:ok, event_type}
    end
  end

  def update(event_type, params) do
    event_type
    |> EventType.changeset(params)
    |> Repo.update()
  end

  def clone(%EventType{name: name, slug: _slug} = event_type) do
    event_type
    |> Map.from_struct()
    |> Map.put(:name, "#{name} (clone)")
    |> insert()
  end

  def delete(event_type) do
    event_type
    |> EventType.delete_changeset()
    |> Repo.update()
  end
end
