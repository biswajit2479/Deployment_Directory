module CompaniesHelper

  def company_plugins company
    company.plugins.pluck(:name)
  end

  def company_deployments company
    company.deployments.pluck(:id)
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
