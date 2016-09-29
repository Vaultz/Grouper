class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.integer :id_user
      t.integer :id_project
      t.integer :project_leader
      
      t.timestamps
    end
  end
end
