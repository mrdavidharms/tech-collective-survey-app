class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  paginates_per 1
  validates :body, presence: true


end
