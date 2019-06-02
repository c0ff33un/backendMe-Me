class AddColumsToMeme < ActiveRecord::Migration[5.2]
  def change
    add_column :memes, :swipe_up, :integer, :default =>0
    add_column :memes, :swipe_down, :integer, :default =>0
    add_column :memes, :swipe_left, :integer, :default =>0
    add_column :memes, :swipe_right, :integer, :default =>0
  end
end
