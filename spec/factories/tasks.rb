FactoryBot.define do

  factory :task do
    title { 'Factorybotで作成したタイトル１' }
    content { 'Factorybotで作成したコンテンツ１' }
    created_at { Date.today }
    limit { Date.today+5 }
    status { 'not_yet_arrived' }
    priority { '高' }
  end
 
end
