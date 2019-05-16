class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :commentable, polymorphic: true, index: true
      t.text :body

      t.timestamps
    end
  end
end
