class Questions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.boolean :rating
      t.boolean :multiple_choice
      t.boolean :required?
      t.string :body, null: false
      t.belongs_to :survey, null: false

      t.timestamps
    end
  end
end
