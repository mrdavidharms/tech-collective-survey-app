class Survey < ActiveRecord::Base
  belongs_to :admin
  has_many :questions
  has_many :answers, through: :survey_answers
  validates :title, presence: true

end
