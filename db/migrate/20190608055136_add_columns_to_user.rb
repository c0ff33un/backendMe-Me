class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :memes_count, :integer, :default =>0
    add_column :users, :posts_count, :integer, :default =>0
    add_column :users, :comments_count, :integer, :default =>0
    add_column :users, :swipe_up, :integer, :default =>0
    add_column :users, :swipe_down, :integer, :default =>0
    add_column :users, :swipe_left, :integer, :default =>0
    add_column :users, :swipe_right, :integer, :default =>0
  end
end
