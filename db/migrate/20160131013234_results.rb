class Results < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.belongs_to :surveys
      t.belongs_to :answers
    end
  end
end
