class Question < ActiveRecord::Base
  belongs_to :survey
  validates :body, presence: true
end
