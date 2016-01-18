class Surveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.string :type

      t.timestamp
    end
  end
end
