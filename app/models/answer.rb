class Answer < ActiveRecord::Base
  has_many :surveys, through: :survey_answers
  belongs_to :question
end
