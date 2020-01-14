class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :title, null: false, unique: true
      t.integer :task_id, null: false

      t.timestamps
    end
  end
end
