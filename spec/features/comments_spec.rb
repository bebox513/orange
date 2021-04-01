require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  let(:user) {create(:user)}
  feature 'コメント投稿前' do
    background 'ログイン' do
      visit root_path
      click_on "ログイン"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "ログイン"
    end
    background '投稿' do
      visit root_path
      click_on "投稿作成"
      fill_in "post_content", with: "テスト投稿"
      click_button "作成する"
    end
    scenario 'コメント投稿できるか' do
      expect {
        visit root_path
        click_link("post-link")
        fill_in "comment_content", with: "テストコメント"
        find("button").click
      }.to change{ Comment.count }.by(1)
    end
  end
end
