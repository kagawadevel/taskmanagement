class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :title, :string, default: 0
    change_column_null :tasks, :title, :string, null: false
  end
end
