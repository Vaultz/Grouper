class AddColumnToWorkshop < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :year ,:integer, :limit => 2
  end
end
