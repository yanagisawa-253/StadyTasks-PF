class RenameStartIdColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :start_id, :start_time
  end
end
