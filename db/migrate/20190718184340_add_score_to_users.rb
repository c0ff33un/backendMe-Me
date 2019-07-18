class AddScoreToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :memes, :score, :integer, :default =>0
  end
end
