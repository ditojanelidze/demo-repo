class CreateLikesInfo < ActiveRecord::Migration[8.0]
  def change
    create_table :likes_infos do |t|
      t.references :post, foreign_key: true, null: false, index: { unique: true }
      t.integer :likes_count, default: 0, null: false
      t.timestamps
    end
  end
end
