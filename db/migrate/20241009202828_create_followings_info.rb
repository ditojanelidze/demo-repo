class CreateFollowingsInfo < ActiveRecord::Migration[8.0]
  def change
    create_table :followings_infos do |t|
      t.references :user, foreign_key: true, null: false, index: { unique: true }
      t.integer :followers_count, default: 0, null: false
      t.integer :following_count, default: 0, null: false
    end
  end
end
