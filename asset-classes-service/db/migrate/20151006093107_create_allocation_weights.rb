class CreateAllocationWeights < ActiveRecord::Migration
  def change
    create_table :allocation_weights do |t|
      t.integer :tolerance_level
      t.decimal :weight

      t.timestamps
    end
  end
end