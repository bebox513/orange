require 'rails_helper'

RSpec.feature 'CareDiaries', type: :feature do
  let(:user) {create(:user)}
  background 'ユーザーログイン' do
    visit root_path
    click_on "ログイン"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
  end
  feature '作成前' do
    scenario '介護日誌一覧ページに遷移できるか' do
      visit root_path
      click_on "介護日誌"
      expect(page).to have_content("#{user.name}の介護記録")
    end
    scenario '介護日誌作成ページに遷移できるか' do
      visit care_diaries_path
      click_on "介護日誌作成"
      expect(current_path).to eq new_care_diary_path
    end
    scenario '介護日誌を作成できるか' do
      expect {
        visit new_care_diary_path
        fill_in "care_diary_date", with: Date.today
        fill_in "care_diary_temperature", with: 36.5
        fill_in "care_diary_breakfast_meal_intake", with: 10
        fill_in "care_diary_lunch_meal_intake", with: 10
        fill_in "care_diary_dinner_meal_intake", with: 10
        fill_in "care_diary_notes", with: "テスト"
        click_on "作成する"
      }.to change{ CareDiary.count }.by(1)
    end
  end
  feature '介護日誌作成後' do
    background '介護日誌作成' do
      visit new_care_diary_path
      fill_in "care_diary_date", with: Date.today
      fill_in "care_diary_temperature", with: 36.5
      fill_in "care_diary_breakfast_meal_intake", with: 10
      fill_in "care_diary_lunch_meal_intake", with: 10
      fill_in "care_diary_dinner_meal_intake", with: 10
      fill_in "care_diary_notes", with: "テスト"
      click_on "作成する"
    end
    scenario '介護日誌編集ページに遷移できるか' do
      date = Date.today.day
      visit care_diaries_path
      click_on date
      expect(page).to have_content(date)
    end
    scenario '介護日誌を編集できるか' do
      date = Date.today.day
      visit care_diaries_path
      click_on date
      find(".care-diary-edit-btn").click
      fill_in "care_diary_notes", with: "編集テスト"
      click_on "編集する"
      expect(page).to have_content("編集テスト")
    end
  end
end
