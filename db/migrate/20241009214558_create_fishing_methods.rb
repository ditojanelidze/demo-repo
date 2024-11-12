class CreateFishingMethods < ActiveRecord::Migration[8.0]
  def change
    create_table :fishing_methods do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
