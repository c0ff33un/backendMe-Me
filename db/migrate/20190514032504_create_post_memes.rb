class CreatePostMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :post_memes do |t|
      t.belongs_to :post, foreign_key: true
      t.belongs_to :meme, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
