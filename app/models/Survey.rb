class Survey < ActiveRecord::Base
  belongs_to :admin
  has_many :questions

end
