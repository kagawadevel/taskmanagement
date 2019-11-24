require 'rails_helper'

RSpec.describe Task, type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'testtask01'
        fill_in 'task_content', with: 'testtesttest'
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
         task = Task.create!(title: 'test_title01', content: 'test_content02')

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
        expect(page).to have_content "Factoryで作ったデフォルトのコンテント２"
      end
    end
  end
end
