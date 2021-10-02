class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :task_comment_id
      t.integer :visitor_id
      t.integer :visited_id
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
