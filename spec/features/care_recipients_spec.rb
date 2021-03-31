require 'rails_helper'

RSpec.feature 'CareRecipients', type: :feature do
  let(:user2) {create(:user2)}
  background 'ユーザーログイン' do
    visit root_path
    click_on "ログイン"
    fill_in "user_email", with: user2.email
    fill_in "user_password", with: user2.password
    click_button "ログイン"
  end
  feature '利用者登録前' do
    scenario '利用者一覧ページに遷移できるか' do
      visit root_path
      click_on "利用者一覧"
      expect(page).to have_content("利用者一覧")
    end
    scenario '利用者登録ページに遷移できるか' do
      visit care_recipients_path
      click_on "利用者を作成する"
      expect(current_path).to eq new_care_recipient_path
    end
    scenario '利用者登録できるか' do
      expect {
        visit new_care_recipient_path
        fill_in "care_recipient_name", with: "テストユーザー"
        select "男", from: "care_recipient_sex"
        fill_in "care_recipient_age", with: "80"
        fill_in "care_recipient_birthday", with: Date.today
        select "1", from: "care_recipient_degree_care_required"
        select "有り", from: "care_recipient_dementia"
        fill_in "care_recipient_notes", with: "テスト"
        click_on "作成する"
      }.to change{ CareRecipient.count }.by(1)
    end
  end
  feature '利用者登録後' do
    background '利用者登録' do
      visit new_care_recipient_path
      fill_in "care_recipient_name", with: "テストユーザー"
      select "男", from: "care_recipient_sex"
      fill_in "care_recipient_age", with: "80"
      fill_in "care_recipient_birthday", with: Date.today
      select "1", from: "care_recipient_degree_care_required"
      select "有り", from: "care_recipient_dementia"
      fill_in "care_recipient_notes", with: "テスト"
      click_on "作成する"
    end
    scenario '利用者個別ページに遷移できるか' do
      visit care_recipients_path
      click_on "テストユーザー"
      expect(page).to have_content("個別情報")
    end
    scenario '利用者情報を編集できるか' do
      visit care_recipients_path
      click_on "テストユーザー"
      find(".care-recipient-edit-btn").click
      fill_in "care_recipient_name", with: "テストユーザー編集"
      click_on "編集する"
      expect(page).to have_content("テストユーザー編集")
    end
  end
end
