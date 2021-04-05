require 'rails_helper'

RSpec.feature 'Relationships', type: :feature do
  let(:user) {create(:user)}
  let(:user2) {create(:user2)}
  background 'userでログインし投稿' do
    visit root_path
    click_on "ログイン"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
    click_on "投稿作成"
    fill_in "post_content", with: "テスト投稿"
    click_button "作成する"
    click_on "ログアウト"
  end
  background 'user2でログインし投稿' do
    visit root_path
    click_on "ログイン"
    fill_in "user_email", with: user2.email
    fill_in "user_password", with: user2.password
    click_button "ログイン"
    click_on "投稿作成"
    fill_in "post_content", with: "テスト投稿2"
    click_button "作成する"
  end
  feature 'フォーロー前' do
    scenario 'フォロー出来るか' do
      expect {
        visit root_path
        click_link("山田太郎")
        click_on "フォローする"
      }.to change{ Relationship.count }.by(1)
    end
  end
  feature 'フォーロー後' do
    background 'フォロー' do
      visit root_path
      click_link("山田太郎")
      click_on "フォローする"
    end
    scenario 'フォロー解除出来るか' do
      expect {
        visit root_path
        click_link("山田太郎")
        click_on "フォロー済み"
      }.to change{ Relationship.count }.by(-1)
    end
  end
end
