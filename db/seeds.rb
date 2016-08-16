# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.production?
admin = Admin.find_or_create_by!([{email: "yo@yo.com", id:10000000}])
survey = Survey.find_or_create_by!([{ title: 'Example Survey', group: 'Example Group', publish: true, admin_id: admin.first.id }])
questions = [Question.find_or_create_by!([{ body: "How much do you like this question on a scale of one to ten?", rating: true, survey_id: survey.first.id }]),
 Question.find_or_create_by!([{ body: "Explain how you feel about this question?", text: true, survey_id: survey.first.id  }]),
 Question.find_or_create_by!([{ body: "Explain and mark how much do you like this question on a scale of one to ten.", text: true, rating: true, survey_id: survey.first.id  }])]
end
