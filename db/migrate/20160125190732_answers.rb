class Answers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.string :rating_answer
      t.string :selection
      t.belongs_to :survey, null: false

      t.timestamps
    end
  end
end
