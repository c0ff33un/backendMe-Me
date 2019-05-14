class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :meme, foreign_key: true
      t.integer :reaction_type

      t.timestamps
    end
  end
end
