class AddTypeLien < ActiveRecord::Migration[5.0]
  def change
    add_column :liens, :type, :string
  end
end
