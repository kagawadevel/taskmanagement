FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
  end

  factory :second_task, class: Task do
   title { 'Factoryで作ったデフォルトのタイトル２' }
   content { 'Factoryで作ったデフォルトのコンテント２' }
 end
 
end
