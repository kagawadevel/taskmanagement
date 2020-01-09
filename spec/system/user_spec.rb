require 'rails_helper'

RSpec.describe User, type: :system do

  before do
    FactoryBot.create(:user)
  end

  describe 'ログイン画面' do
    context 'ログインした場合' do
      it 'マイページに変遷されること' do
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'testuser1@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        expect(page).to have_content 'テストユーザー１'
      end
    end
  end

  describe 'ログインしていない状態' do
    context 'タスク一覧ページへ移行する場合' do
      it "ログイン画面へリダイレクトされること" do
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'testuser1@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        click_on 'ログアウト'
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe 'ログインしている状態' do
    context 'タスク一覧ページへ移行した場合' do
      it "自分が作成したタスクのみが表示されていること" do
        FactoryBot.create(:user, id: 2, email: "testuser2@com")

        FactoryBot.create(:task,
                          title: "テストユーザー１作成タスクタイトル",
                          content: 'テストユーザー１作成タスクコンテンツ',
                          user_id: 1)

        FactoryBot.create(:task,
                          title: "テストユーザー２作成タスクタイトル",
                          content: 'テストユーザー２作成タスクコンテンツ',
                          user_id: 2)

        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'testuser1@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        visit tasks_path
        expect(page).to_not have_content 'テストユーザー２作成タスクコンテンツ'
      end
    end
  end

  describe 'ログインしている状態' do
    context '再度ログインする場合' do
      it "マイページへリダイレクトされること" do
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'testuser1@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        visit sessions_new_url
        expect(page).to have_content 'すでにログインしています'
      end
    end
  end

  describe 'ログインしている状態' do
    context '自分以外のユーザーのページに移行するとき' do
      it "マイページへリダイレクトされること" do
        FactoryBot.create(:user, id: 2, email: "testuser2@com")
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'testuser1@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        visit user_path(2)
        expect(page).to have_content 'ユーザーが違います'
      end
    end
  end

  end