require 'rails_helper'

RSpec.feature 'Messages', type: :feature do
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
  background '相互フォローする' do
    visit root_path
    click_link("山田太郎")
    click_on "フォローする"
    click_on "ログアウト"
    click_on "ログイン"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
    click_link("山田美智子")
    click_on "フォローする"
  end
  feature 'メッセージルーム作成後' do
    background 'メッセージルーム作成' do
      visit root_path
      click_on "メッセージ"
      click_on "新たにチャットルームを作成する"
      fill_in "room_name", with: "テストルーム"
      check "山田美智子"
      click_on "作成する"
    end
    scenario 'メッセージ作成出来るか' do
      expect {
        fill_in "message_content", with: "テストメッセージ"
        find("button").click
      }.to change{ Message.count }.by(1)
    end
  end
end
