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
      FactoryBot.create(:label)
    end
      context 'ラベル付タスクを作成した場合' do
        it 'タスク詳細にそのラベルが表示されること' do
          visit new_task_path
          fill_in 'task_title', with: 'testtask1'
          fill_in 'task_content', with: 'testtaasktitle1'
          select "2020", from: "task_limit_1i"
          select "12", from: "task_limit_2i"
          select "31", from: "task_limit_3i"
          check "テストラベル"
          click_on '登録する'
          click_on '登録する'
          click_on "確認", match: :first
          expect(page).to have_content 'テストラベル'
        end
      end
  end


end