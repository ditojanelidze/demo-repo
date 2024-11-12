class CreatePost < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.text :description, null: false
      t.references :user, foreign_key: true, null: false
      t.references :fish_specie, foreign_key: true, null: false
      t.references :fishing_method, foreign_key: true, null: false
      t.point :location
      t.string :location_name, null: false
      t.string :rod
      t.string :bait
      t.decimal :weight
      t.string :workflow_state, null: false
      t.timestamps
      t.datetime :deleted_at, index: true
    end
  end
end
