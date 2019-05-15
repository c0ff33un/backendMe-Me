class CreateMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :memes do |t|
      t.belongs_to :user, foreign_key: true
      t.binary :image

      t.timestamps
    end
  end
end
