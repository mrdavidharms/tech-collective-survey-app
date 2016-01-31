class Answer < ActiveRecord::Base
  has_many :surveys, through: :results
  belongs_to :question
end
