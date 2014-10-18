class AddDefaultConfiguration < ActiveRecord::Migration
  def change
    ::Configuration.create(global_support: 0.25, cluster_support: 0.30, number_cluster: 30)
  end
end
