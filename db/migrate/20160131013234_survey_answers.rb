class SurveyAnswers < ActiveRecord::Migration
  def change
    create_table :surveyanswers do |t|
      t.belongs_to :surveys
      t.belongs_to :answers
    end
  end
end
