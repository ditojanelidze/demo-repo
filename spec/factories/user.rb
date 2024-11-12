FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    phone_number { "+1234567890" }
    phone_number_iso { "US" }
    password { "password" }
    password_digest { BCrypt::Password.create('password') }
    workflow_state { 'pending' }
  end
end