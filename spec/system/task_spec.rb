require 'rails_helper'

RSpec.describe Task, type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:task)
    FactoryBot.create(:task, id: 10, title: "Factorybotで作成したタイトル２", content: 'Factorybotで作成したコンテンツ２', created_at: Date.today-3, limit: Date.today+3, status: 'not_yet_arrived', priority: '高')
    FactoryBot.create(:task, id: 11, title: "Factorybotで作成したタイトル３", content: 'Factorybotで作成したコンテンツ３', created_at: Date.today-5, limit: Date.today-1, status: 'not_yet_arrived', priority: '高')
    visit sessions_new_url
    fill_in 'メールアドレス：', with: 'testuser1@com'
    fill_in 'パスワード：', with: 'password'
    click_on 'ログインする'
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path
        expect(page).to have_content 'タイトル１'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'testtask01'
        fill_in 'task_content', with: 'testtesttest'
        select "2020", from: "task_limit_1i"
        select "12", from: "task_limit_2i"
        select "31", from: "task_limit_3i"
        click_on '登録する'
        click_on '登録する'
        expect(page).to have_content 'testtask01'
        expect(page).to have_content 'testtesttest'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         visit new_task_path
         task = Task.create(title: 'test_title01', content: 'test_content02', user_id: 1)
         visit task_path(task.id)
         expect(page).to have_content 'test_title01'
         expect(page).to have_content 'test_content02'
       end
     end
  end

  describe "タスク一覧画面" do
    context 'タスク一覧画面に遷移した場合' do
      it 'タスク一覧が作成日時順に並んでいること' do
        visit tasks_path
        click_on "確認", match: :first
        expect(page).to have_content "Factorybotで作成したコンテンツ１"
      end
    end
  end

  describe "タスク一覧画面" do
    context '終了期限でソートするをクリックした場合' do
      it 'タスクが終了期限順に並んでいること' do
        @task2 = FactoryBot.create(:task, id: 12, title: "期限を超過したタスク", content: '期限を超過したタスク', created_at: Date.today-9, limit: Date.today-9, status: 'not_yet_arrived', priority: '高')
        visit tasks_path
        click_on "終了期限でソートする"
        click_on "確認", match: :first
        expect(page).to have_content "超過"
      end
    end
  end
end