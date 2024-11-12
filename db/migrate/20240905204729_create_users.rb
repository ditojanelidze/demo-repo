class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 50
      t.string :last_name, null: false, limit: 50
      t.string :password_digest, null: false
      t.string :phone_number, null: false
      t.string :phone_number_iso, null: false, limit: 2
      t.string :phone_number_confirmation_token, limit: 150
      t.string :phone_number_confirmation_code, limit: 4
      t.datetime :phone_number_confirmation_code_sent_at
      t.string :password_recovery_token, limit: 150
      t.string :password_recovery_code, limit: 4
      t.datetime :password_recovery_code_sent_at
      t.datetime :last_sign_in_at
      t.string :workflow_state, null: false
      t.string :avatar
      t.string :locale, null: false, limit: 4, default: :ge
      t.timestamps
      t.datetime :deleted_at, index: true
    end

    add_index :users, :phone_number, unique: true, where: "workflow_state = 'active' AND deleted_at IS NULL", name: 'index_unique_phone_number_active'
  end
end
