class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string, null: false, default: "not_yet_arrived"
  end
end
