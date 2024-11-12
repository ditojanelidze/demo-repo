class CreateFollowings < ActiveRecord::Migration[8.0]
  def change
    create_table :followings do |t|
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.references :followed, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end

    # Ensure a user can't follow the same user more than once
    add_index :followings, [:follower_id, :followed_id], unique: true
  end
end
