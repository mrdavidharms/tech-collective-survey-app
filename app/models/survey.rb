class Survey < ActiveRecord::Base
  belongs_to :admin
  has_many :questions
  has_many :answers, through: :surveyanswers
  validates :title, presence: true

end
