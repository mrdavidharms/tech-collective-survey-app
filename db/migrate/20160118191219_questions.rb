class Questions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.boolean :rating
      t.boolean :multiple_choice
      t.string :multiple_choice_1
      t.string :multiple_choice_2
      t.string :multiple_choice_3
      t.string :multiple_choice_4
      t.string :multiple_choice_5
      t.boolean :required?
      t.boolean :text?
      t.string :body, null: false
      t.belongs_to :survey, null: false

      t.timestamps
    end
  end
end
