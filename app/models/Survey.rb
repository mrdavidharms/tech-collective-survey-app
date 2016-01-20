class Survey < ActiveRecord::Base
  belongs_to :admin
  has_many :questions
  validates :title, presence: true
  
end
