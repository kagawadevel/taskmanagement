FactoryBot.define do

  factory :task do
    title { 'Factorybotで作成したタイトル１' }
    content { 'Factorybotで作成したコンテンツ１' }
    created_at { Date.today-1 }
    limit { Date.today+5 }
    status { 'not_yet_arrived' }
    priority { '高' }
  end

  factory :secondtask do
    title { '期限を超過したタスク' }
    content { '期限を超過したタスク' }
    created_at { Date.today-9 }
    limit { Date.today-9 }
    status { 'not_yet_arrived' }
    priority { '高' }
  end
 
end
