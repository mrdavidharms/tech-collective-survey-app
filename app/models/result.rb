class Result < ActiveRecord::Base
  belongs_to :surveys
  belongs_to :questions
end
