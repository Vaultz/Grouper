class ProjectLeaderToInt < ActiveRecord::Migration[5.0]
  def change
    change_column(:workshops,:projectleaders, :integer, :limit=>1)
  end
end
