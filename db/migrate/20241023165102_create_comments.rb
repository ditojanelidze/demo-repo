class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.string :content, null: false, limit: 500
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
