module EventsHelper
  def event_plugins event
    event.plugins.pluck(:name)
  end

  def staging_ids
    Cluster.where(name: "staging").ids
  end

  def demo_ids
    Cluster.where(name: "demo").ids
  end

  def prod_ids
    Cluster.where(name: "PROD").ids
  end
end
