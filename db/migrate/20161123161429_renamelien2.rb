class Renamelien2 < ActiveRecord::Migration[5.0]
  def change
    rename_column :liens, :typeliens, :logo
  end
end
