require 'rails_helper'

RSpec.describe CareRecipient, type: :model do
  context "バリデーション" do
    it "名前、性別、生年月日、年齢、担当事業所、担当ケアマネージャー、要介護度、認知症があれば有効な状態であること" do
      care_recipient = create(:care_recipient)
      expect(care_recipient).to be_valid
    end
    it "名前がなければ無効な状態であること" do
      care_recipient = build(:care_recipient, name: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:name]).to include("を入力してください")
    end
    it "ユーザーネームが10文字以内であること" do
      care_recipient = build(:care_recipient, name: "a" * 10)
      expect(care_recipient).to be_valid
    end
    it "ユーザーネームが11文字以上の場合無効であること" do
      care_recipient = build(:care_recipient, name: "a" * 11)
      care_recipient.valid?
      expect(care_recipient.errors[:name]).to include("は10文字以内で入力してください")
    end
    it "性別がなければ無効な状態であること" do
      care_recipient = build(:care_recipient, sex: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:sex]).to include("を入力してください")
    end
    it "生年月日がなければ無効な状態であること" do
      care_recipient = build(:care_recipient, birthday: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:birthday]).to include("を入力してください")
    end
    it "年齢がなければ無効な状態であること" do
      care_recipient = build(:care_recipient, age: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:age]).to include("を入力してください")
    end
    it "年齢が数値でなければ無効な状態であること" do
      care_recipient = build(:care_recipient, age: "a")
      care_recipient.valid?
      expect(care_recipient.errors[:age]).to include("は数値で入力してください")
    end
    it "担当事業所がなければ無効な状態であること" do
      care_recipient = build(:care_recipient, facility_in_charge: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:facility_in_charge]).to include("を入力してください")
    end
    it "担当事業所が50文字以内であること" do
      care_recipient = build(:care_recipient, facility_in_charge: "a" * 10)
      expect(care_recipient).to be_valid
    end
    it "ケアマネージャーがなければ無効な状態であること" do
      care_recipient = build(:care_recipient, manager_in_charge: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:manager_in_charge]).to include("を入力してください")
    end
    it "担当ケアマネージャーが10文字以内であること" do
      care_recipient = build(:care_recipient, manager_in_charge: "a" * 10)
      expect(care_recipient).to be_valid
    end
    it "要介護度がなければ無効な状態であること" do
      care_recipient = build(:care_recipient, degree_care_required: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:degree_care_required]).to include("を入力してください")
    end
    it "要介護度が数値でなければ無効な状態であること" do
      care_recipient = build(:care_recipient, degree_care_required: "a")
      care_recipient.valid?
      expect(care_recipient.errors[:degree_care_required]).to include("は数値で入力してください")
    end
    it "認知症がなければ無効な状態であること" do
      care_recipient = build(:care_recipient, dementia: nil)
      care_recipient.valid?
      expect(care_recipient.errors[:dementia]).to include("を入力してください")
    end
  end
end
