class RenameId < ActiveRecord::Migration[5.0]
  def change
      change_table :works do |t|
          t.rename :id_user, :user_id
          t.rename :id_project, :project_id
      end

      change_table :workshops do |t|
          t.rename :createdby, :user_id
      end
  end
end
