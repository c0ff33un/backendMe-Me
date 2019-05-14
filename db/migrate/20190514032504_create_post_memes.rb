class CreatePostMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :post_memes do |t|
      t.references :post, foreign_key: true
      t.references :meme, foreign_key: true

      t.timestamps
    end
  end
end
