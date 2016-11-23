class Renamelien < ActiveRecord::Migration[5.0]
  def change
    rename_column :liens, :type, :typeliens
  end
end
