class AddProjectleadersTWorkshops < ActiveRecord::Migration[5.0]
  def change
  	add_column :workshops, :projectleaders, :boolean
  end
end
