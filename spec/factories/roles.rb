FactoryGirl.define do
  factory :role do
    sequence(:name) { |n| "name_#{n}" }
  end

  trait :admin_role do
    after(:build) do |role|
      role.name = "admin"
    end
  end

end