class AddWorkshopToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :workshop_id, :integer
  end
end
