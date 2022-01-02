class RenameStartColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :start, :start_id
  end
end
