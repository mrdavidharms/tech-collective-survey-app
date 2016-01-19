class Surveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title, null: false
      t.string :group
      t.boolean :publish, default: false
      t.belongs_to :admin, null: false

      t.timestamps null: false
    end
  end
end
