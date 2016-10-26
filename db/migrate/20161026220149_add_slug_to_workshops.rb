class AddSlugToWorkshops < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :slug, :string
  end
end
