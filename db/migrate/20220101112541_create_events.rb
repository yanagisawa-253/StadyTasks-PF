class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :body
      t.boolean :disp_flg
      t.datetime :start
      t.datetime :end
      t.string :allday
      t.integer :user_id

      t.timestamps
    end
  end
end
