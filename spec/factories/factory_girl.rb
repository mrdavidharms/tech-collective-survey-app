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
    title "Finished survey"
    group "Students"
    publish true
  end

  factory :question do
    sequence(:body) { |n| "How did you feel about this event? #{n}" }
  end

  factory :answer do

  end
end
