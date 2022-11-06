class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title,        null: false
      t.text :content,        null: false
      t.datetime :start_time, null: false
      t.integer :admin_id,    null: false

      t.timestamps
    end
  end
end
