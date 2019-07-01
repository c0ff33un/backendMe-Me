class AddOauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    #remove_column :users, :uid #because last migration is weird
  end
end
