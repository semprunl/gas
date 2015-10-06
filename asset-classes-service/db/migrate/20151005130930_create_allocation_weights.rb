class CreateAllocationWeights < ActiveRecord::Migration
  def change
    create_table :allocation_weights do |t|
      t.belongs_to :asset_class, index:true
      t.integer :tolerance_level
      t.decimal :weight

      t.timestamps
    end
  end
end
