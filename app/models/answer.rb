class Answer < ActiveRecord::Base
  has_many :surveys, through: :surveyanswers
  belongs_to :question
end
