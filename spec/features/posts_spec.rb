require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:user) {create(:user)}
  background 'ユーザーログイン' do
    visit root_path
    click_on "ログイン"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
  end
  feature '投稿前' do
    background '投稿作成ページに遷移' do
      visit root_path
      click_on "投稿作成"
    end
    scenario '投稿作成画面を開けるか' do
      expect(current_path).to eq new_post_path
    end
    scenario '投稿できるか' do
      expect {
        fill_in "post_content", with: "テスト投稿"
        click_button "作成する"
      }.to change{ Post.count }.by(1)
    end
  end
  feature '投稿後' do
    background '投稿作成' do
      visit root_path
      click_on "投稿作成"
      fill_in "post_content", with: "テスト投稿"
      click_button "作成する"
    end
    scenario '投稿詳細ページに遷移できるか' do
      expect(page).to have_content("テスト投稿")
    end
    scenario '投稿編集ページに遷移できるか' do
      visit root_path
      find(".post-edit-btn").click
      expect(page).to have_content("投稿編集")
    end
    scenario '投稿を編集できるか' do
      visit root_path
      find(".post-edit-btn").click
      fill_in "post_content", with: "投稿編集テスト"
      click_on "作成する"
      expect(page).to have_content("投稿編集テスト")
    end
  end
end
