class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.integer :user_id, null: false
      t.binary :privacy, null: false, limit: 1
      t.binary :completed, default: 0, limit: 1

      t.timestamps null: false
    end
      add_index :goals, :user_id
  end
end
