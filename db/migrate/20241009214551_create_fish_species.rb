class CreateFishSpecies < ActiveRecord::Migration[8.0]
  def change
    create_table :fish_species do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
