class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :headline
      t.text :details

      t.timestamps null: false
    end
  end
end
