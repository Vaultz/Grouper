class ChangeYearType < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
        t.change :year, :integer, :limit => 2
    end
  end
end
