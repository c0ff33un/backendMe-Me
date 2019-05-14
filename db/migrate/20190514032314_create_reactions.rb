class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.references :user, foreign_key: true
      t.references :meme, foreign_key: true
      t.integer :reaction_type

      t.timestamps
    end
  end
end
