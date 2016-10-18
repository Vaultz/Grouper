class ChangeProjectLeader < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:workshops,:projectleaders,true)
  end
end
