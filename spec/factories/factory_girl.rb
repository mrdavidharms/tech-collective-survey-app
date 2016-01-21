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

  factory :user_survey, class: Survey do
    title "Grrl Tech"
    group "Students"
    publish true
  end

  factory :question do
    body "How did you feel about this event?"
  end
end
