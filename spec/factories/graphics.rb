FactoryGirl.define do
  factory :graphic do
    sequence(:description) { |n| "description_#{n}" }
    quantity '3'
    width '4'
    height '5'
  end
end