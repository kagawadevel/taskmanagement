require 'rails_helper'

RSpec.describe 'ラベル登録機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:user, id: 2, name: "テストユーザー２", email: 'testuser2@com' )

    visit sessions_new_url
    fill_in 'メールアドレス：', with: 'testuser1@com'
    fill_in 'パスワード：', with: 'password'
    click_on 'ログインする'
  end

  describe 'ラベル登録画面' do
    context 'ラベルのタイトルを入力して、createボタンを押した場合' do
      it 'タスク作成の際にラベルとして表示されること' do
        visit new_label_path
        fill_in 'ラベルのタイトル', with: 'テストラベル１'
        click_on 'ラベルを登録'
        visit new_task_path
        expect(page).to have_content 'テストラベル１'
      end
    end
  end

  describe 'タスク詳細画面' do
    before do
      FactoryBot.create(:label, id: 5)
    end
      context 'ラベル付タスクを作成した場合' do
        it 'タスク詳細にそのラベルが表示されること' do
          visit new_task_path
          fill_in 'task_title', with: 'testtask1'
          fill_in 'task_content', with: 'testtaasktitle1'
          select "2020", from: "task_limit_1i"
          select "12", from: "task_limit_2i"
          select "31", from: "task_limit_3i"
          check("task[label_ids][]")
          click_on '登録する'
          click_on '登録する'
          click_on "確認", match: :first
          expect(page).to have_content 'テストラベル'
        end
      end
  end

  describe '一覧画面' do
    before do
      FactoryBot.create(:label, id: 10, title: 'テストラベル１')
      FactoryBot.create(:label, id: 11, title: 'テストラベル２')
      FactoryBot.create(:task, id: 1, title: "テストタスク１", content: 'テストタスクコンテンツ１')
      FactoryBot.create(:task, id: 2, title: "テストタスク２", content: 'テストタスクコンテンツ２')
      FactoryBot.create(:task_label, task_id: 1, label_id: 10)
      FactoryBot.create(:task_label, task_id: 2, label_id: 11)
    end
    context 'ラベル検索機能を利用した場合' do
      it '選択したラベルのつくタスクのみが表示されること' do
        visit tasks_path
        fill_in 'task[title]', with: ''
        select 'テストラベル１', from: 'task[label_ids]'
        click_on "確認", match: :first
        expect(page).not_to have_content 'テストタスク２'
        expect(page).not_to have_content 'テストラベル２'
      end
    end
  end

  describe '他のユーザーが作成したラベルが表示されないこと' do
    before do
      FactoryBot.create(:label, id: 10, title: 'ユーザー１が作成したラベル', user_id: 1)
      FactoryBot.create(:label, id: 11, title: 'ユーザー２が作成したラベル', user_id: 2)

    end
    context '新しいタスクを作成するとき' do
      it '他のユーザーが作成したラベルが表示されないこと' do
        visit new_task_path
        expect(page).to have_content 'ユーザー１が作成したラベル'
        expect(page).to_not have_content 'ユーザー２が作成したラベル'
      end
    end
  end


end