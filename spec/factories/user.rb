FactoryBot.define do
  factory :user do
    # authentication_token 'H3LL0W0RLD'
    sequence(:email) { |n| "john.smith#{n}@lendstreet.com" }
    # confirmed_at Time.zone.now # Skip confirmation.
    password 'AbcD5678'
    password_confirmation 'AbcD5678'
  end
end
