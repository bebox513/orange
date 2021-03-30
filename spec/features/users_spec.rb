require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  feature 'ユーザー登録前' do
    def user_create
      fill_in "user_email", with: "test@example.com"
      fill_in "user_name", with: "テストユーザー"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
    end
    scenario 'role1のユーザーを作成できるか' do
      visit root_path
      click_on "新規登録"
      click_on "ご本人様、またはご家族のご利用はこちら"
      user_create
      click_button "新規登録"
      expect(page).to have_content("最新の投稿")
    end
    scenario 'role2のユーザーを作成できるか' do
      visit root_path
      click_on "新規登録"
      click_on "介護施設の職員のご利用はこちら"
      user_create
      click_button "新規登録"
      expect(page).to have_content("最新の投稿")
    end
    scenario 'role3のユーザーを作成できるか' do
      visit root_path
      click_on "新規登録"
      click_on "ケアマネージャーのご利用はこちら"
      user_create
      click_button "新規登録"
      expect(page).to have_content("最新の投稿")
    end
  end
  feature 'ユーザー登録後' do
    let(:user) {create(:user)}
    background do
      visit root_path
      click_on "ログイン"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "ログイン"
    end
    scenario 'ログインできているか' do
      expect(page).to have_content("最新の投稿")
    end
    scenario 'ログアウトできるか' do
       click_on "ログアウト"
       expect(page).to have_content("最新の投稿")
    end
    scenario 'マイページに遷移できるか' do
      click_on user.name
      expect(page).to have_content("投稿一覧")
    end
    scenario 'ユーザー情報を編集できるか' do
      click_on user.name
      click_on "プロフィール編集"
      fill_in "user_name", with: "テストユーザー"
      click_on "編集確定"
      expect(page).to have_content("テストユーザー")
    end
  end
end
