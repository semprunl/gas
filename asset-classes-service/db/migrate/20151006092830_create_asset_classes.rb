class CreateAssetClasses < ActiveRecord::Migration
  def change
    create_table :asset_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end