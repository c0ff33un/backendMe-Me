class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.text :description

      t.timestamps
    end
  end
end
