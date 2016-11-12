FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:email) { |n| "user_#{n}@test.com" }
    password 'User1234'
    password_confirmation 'User1234'
    association(:role)
  end

  trait :client_user do
    after(:build) do |user|
      role = FactoryGirl.build(:role)
      user.role = role
    end
  end

  trait :admin_user do
    after(:build) do |user|
      role = FactoryGirl.build(:role, :admin_role)
      user.role = role
    end
  end

end