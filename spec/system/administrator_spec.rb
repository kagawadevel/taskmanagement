require 'rails_helper'

RSpec.describe User, type: :system do

  before do
    FactoryBot.create(:user, id: 2, name: "kanrisya", email: "kanrisya@com", admin: true)
    FactoryBot.create(:user)
  end

  describe '管理者権限でログインしているとき' do
    context 'ユーザーを作成' do
      it '新規ユーザーが作成できること' do
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'kanrisya@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        click_on '新規ユーザーを作成'
        fill_in 'ユーザー名', with: 'created_user'
        fill_in 'メールアドレス', with: 'createduser@com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        check '管理者権限'
        click_on '送信'
        expect(page).to have_content 'created_user'
      end
    end
  end

  describe '管理者権限でログインしているとき' do
    context 'ユーザー詳細画面に推移' do
      it 'ユーザー詳細画面を確認できること' do
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'kanrisya@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        click_on '新規ユーザーを作成'
        fill_in 'ユーザー名', with: 'created_user'
        fill_in 'メールアドレス', with: 'createduser@com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        check '管理者権限'
        click_on '送信'
        FactoryBot.create(:task, user_id: 2)
        click_on "確認", match: :first
        expect(page).to have_content 'ユーザー詳細画面'
        end
      end
    end
  end

  describe '管理者権限でログインしているとき' do
    context 'ユーザー情報を更新したとき' do
      it 'ユーザー情報を更新できること' do
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'kanrisya@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        click_on '新規ユーザーを作成'
        fill_in 'ユーザー名', with: 'updated_user'
        fill_in 'メールアドレス', with: 'updateduser@com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        check '管理者権限'
        click_on '送信'
        expect(page).to have_content 'updated_user'
      end
    end
  end

  describe '管理者権限でログインしているとき' do
    context 'ユーザーを削除したとき' do
      it 'ユーザーが削除できること' do
        visit sessions_new_url
        fill_in 'メールアドレス：', with: 'kanrisya@com'
        fill_in 'パスワード：', with: 'password'
        click_on 'ログインする'
        click_on '新規ユーザーを作成'
        fill_in 'ユーザー名', with: 'created_user'
        fill_in 'メールアドレス', with: 'createduser@com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        check '管理者権限'
        click_on '送信'
        click_on '削除', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content 'created_user'
      end
    end
  end

  end