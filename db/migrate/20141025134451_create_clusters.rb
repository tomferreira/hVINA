class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.integer :status

      t.timestamps
    end
  end
end
