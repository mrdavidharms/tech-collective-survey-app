class Admin < ActiveRecord::Base
  has_many :surveys
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
