class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.integer :status
      t.string :result_name

      t.timestamps
    end
  end
end
