FactoryBot.define do
  factory :label do
    id {1}
    title {'テストラベル'}
    user_id {1}
  end

  factory :task_labels do
    task_id {1}
    label_id{1}
  end
end
