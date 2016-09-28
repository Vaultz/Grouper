class CreateWorkshops < ActiveRecord::Migration[5.0]
  def change
    create_table :workshops do |t|
      t.string :name
      t.text :description
      t.integer :createdby
      t.string :teacher
      t.date :begins
      t.date :ends
      t.integer :teamgeneration
      t.integer :teamnumber

      t.timestamps
    end
  end
end
