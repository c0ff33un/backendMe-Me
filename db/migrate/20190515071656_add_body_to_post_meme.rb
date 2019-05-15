class AddBodyToPostMeme < ActiveRecord::Migration[5.2]
  def change
    add_column :post_memes, :body, :text
  end
end
