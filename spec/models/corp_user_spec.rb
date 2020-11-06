require 'rails_helper'

RSpec.describe CorpUser, type: :model do
  context "バリデーション" do
    it "名前、メール、パスワードがあれば有効な状態であること" do
      corp_user = create(:corp_user)
      expect(corp_user).to be_valid
    end
    it "ユーザーネームがなければ無効な状態であること" do
      corp_user = build(:corp_user, name: nil)
      corp_user.valid?
      expect(corp_user.errors[:name]).to include("を入力してください")
    end
    it "ユーザーネームが10文字以内であること" do
      corp_user = build(:corp_user, name: "a" * 10)
      expect(corp_user).to be_valid
    end
    it "ユーザーネームが11文字以上の場合無効であること" do
      corp_user = build(:corp_user, name: "a" * 11)
      corp_user.valid?
      expect(corp_user.errors[:name]).to include("は10文字以内で入力してください")
    end
    it "メールアドレスがなければ無効な状態であること" do
      corp_user = build(:corp_user, email: nil)
      corp_user.valid?
      expect(corp_user.errors[:email]).to include("を入力してください")
    end
    it "メールアドレスが50文字以内であれば有効であること" do
      corp_user = build(:corp_user, email: "#{"a" * 38}@example.com")
      expect(corp_user).to be_valid
    end
    it "メールアドレスが51文字以上だと無効であること" do
      corp_user = build(:corp_user, email: "#{"a" * 39}@example.com")
      corp_user.valid?
      expect(corp_user.errors[:email]).to include("は50文字以内で入力してください")
    end
    it "重複したメールアドレスなら無効な状態であること" do
      create(:corp_user, email: "yamada@example.com")
      corp_user = build(:corp_user, email: "yamada@example.com")
      corp_user.valid?
      expect(corp_user.errors[:email]).to include("はすでに存在します")
    end
    it "メールアドレスに@がないと無効な状態であること" do
      corp_user = build(:corp_user, email: "a" * 20)
      corp_user.valid?
      expect(corp_user.errors[:email]).to include("が間違っています")
    end
    it "パスワードがなければ無効な状態であること" do
      corp_user = build(:corp_user, password: nil)
      corp_user.valid?
      expect(corp_user.errors[:password]).to include("を入力してください")
    end
    it "パスワードが5文字以上であれば有効であること" do
      corp_user = build(:corp_user, password: "a" * 5)
      expect(corp_user).to be_valid
    end
    it "パスワードが4文字以内だと無効であること" do
      corp_user = build(:corp_user, password: "a" * 4)
      corp_user.valid?
      expect(corp_user.errors[:password]).to include("は5文字以上で入力してください")
    end
  end
end
