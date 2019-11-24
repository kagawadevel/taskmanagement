class ChangeColumnNullTasks2 < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :content, :text, default: 0
    change_column_null :tasks, :content, :text, null: false
  end
end
