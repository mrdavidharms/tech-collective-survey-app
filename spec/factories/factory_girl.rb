require 'factory_girl'

FactoryGirl.define do
  factory :admin do
    name 'Mandy'
    sequence(:email) { |n| "person#{n}@email.com" }
    password '12345678'
  end

  factory :survey do
    title "Grrl Tech"
    group "Students"
  end
end
