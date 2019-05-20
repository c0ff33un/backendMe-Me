class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :handle
      t.integer :age
      t.string :pass
      t.string :password_salt

      t.timestamps
    end
  end
end
