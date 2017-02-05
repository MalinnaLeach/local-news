class AddAreaToStories < ActiveRecord::Migration
  def change
    add_reference :stories, :area, index: true, foreign_key: true
  end
end
