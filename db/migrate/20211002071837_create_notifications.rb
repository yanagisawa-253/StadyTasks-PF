class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :task_comment_id
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
