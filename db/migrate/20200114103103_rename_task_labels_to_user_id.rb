class RenameTaskLabelsToUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :labels, :task_id, :user_id
  end
end
