class WorkshopNotNullFields < ActiveRecord::Migration[5.0]
  def change
      change_column_null(:workshops,:name,false)
      change_column_null(:workshops,:description,false)
      change_column_null(:workshops,:teacher,false)
      change_column_null(:workshops,:begins,false)
      change_column_null(:workshops,:ends,false)
      change_column_null(:workshops,:teamgeneration,false)
      change_column_null(:workshops,:teamnumber,false)
      change_column_null(:workshops,:projectleaders,false)
  end
end
