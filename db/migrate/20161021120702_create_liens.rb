class CreateLiens < ActiveRecord::Migration[5.0]
  def change
    create_table :liens do |t|
      t.string :name
      t.string :url
      t.integer :year,  :limit => 2
      
      t.timestamps
    end
  end
end
