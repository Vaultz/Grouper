class RenameColumn < ActiveRecord::Migration[5.0]
  def change
      change_table :users do |t|
      t.rename :prenom, :firstname
      t.rename :nom, :lastname
    end
  end
end
