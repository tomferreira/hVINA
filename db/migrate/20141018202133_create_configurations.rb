class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.float :global_support
      t.float :cluster_support
      t.integer :number_cluster

      t.timestamps
    end
  end
end
