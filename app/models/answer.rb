class Answer < ActiveRecord::Base
  has_many :surveys
  belongs_to :question
end
