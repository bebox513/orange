require 'rails_helper'

RSpec.describe CareDiary, type: :model do
  context "バリデーション" do
    it "名前、日付、体温、朝食、昼食、夕食、特記事項があれば有効な状態であること" do
      care_diary = create(:care_diary)
      expect(care_diary).to be_valid
    end
    it "名前が10文字以内であること" do
      care_diary = create(:care_diary, name: "a" * 10)
      expect(care_diary).to be_valid
    end
    it "名前が11文字以上の場合無効であること" do
      care_diary = build(:care_diary, name: "a" * 11)
      care_diary.valid?
      expect(care_diary.errors[:name]).to include("は10文字以内で入力してください")
    end
    it "体温がなければ無効な状態であること" do
      care_diary = build(:care_diary, temperature: nil)
      care_diary.valid?
      expect(care_diary.errors[:temperature]).to include("を入力してください")
    end
    it "日付がなければ無効な状態であること" do
      care_diary = build(:care_diary, date: nil)
      care_diary.valid?
      expect(care_diary.errors[:date]).to include("を入力してください")
    end
    it "朝食がなければ無効な状態であること" do
      care_diary = build(:care_diary, breakfast_meal_intake: nil)
      care_diary.valid?
      expect(care_diary.errors[:breakfast_meal_intake]).to include("を入力してください")
    end
    it "朝食の割合が11以上であれば無効であること" do
      care_diary = build(:care_diary, breakfast_meal_intake: 11)
      care_diary.valid?
      expect(care_diary.errors[:breakfast_meal_intake]).to include("は11より小さい値にしてください")
    end
    it "昼食がなければ無効な状態であること" do
      care_diary = build(:care_diary, lunch_meal_intake: nil)
      care_diary.valid?
      expect(care_diary.errors[:lunch_meal_intake]).to include("を入力してください")
    end
    it "昼食の割合が11以上であれば無効であること" do
      care_diary = build(:care_diary, lunch_meal_intake: 11)
      care_diary.valid?
      expect(care_diary.errors[:lunch_meal_intake]).to include("は11より小さい値にしてください")
    end
    it "夕食がなければ無効な状態であること" do
      care_diary = build(:care_diary, dinner_meal_intake: nil)
      care_diary.valid?
      expect(care_diary.errors[:dinner_meal_intake]).to include("を入力してください")
    end
    it "夕食の割合が11以上であれば無効であること" do
      care_diary = build(:care_diary, dinner_meal_intake: 11)
      care_diary.valid?
      expect(care_diary.errors[:dinner_meal_intake]).to include("は11より小さい値にしてください")
    end
    it "特記事項が51文字以上だと無効であること" do
      care_diary = build(:care_diary, notes: "#{"a" * 256}")
      care_diary.valid?
      expect(care_diary.errors[:notes]).to include("は255文字以内で入力してください")
    end
  end
end
