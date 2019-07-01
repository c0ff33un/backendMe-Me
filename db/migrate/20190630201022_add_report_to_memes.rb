class AddReportToMemes < ActiveRecord::Migration[5.2]
  def change
    add_column :memes, :report, :integer, :default =>0
  end
end
