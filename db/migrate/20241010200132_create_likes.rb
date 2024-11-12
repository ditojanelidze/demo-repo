class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :post, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :likes, [:post_id, :user_id], unique: true, where: 'deleted_at IS NULL'
  end
end
