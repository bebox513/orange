require 'rails_helper'

RSpec.describe User, type: :model do
  context "バリデーション" do
    it "名前、メール、パスワードがあれば有効な状態であること" do
      user = create(:user)
      expect(user).to be_valid
    end
    it "ユーザーネームがなければ無効な状態であること" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
    it "ユーザーネームが10文字以内であること" do
      user = build(:user, name: "a" * 10)
      expect(user).to be_valid
    end
    it "ユーザーネームが11文字以上の場合無効であること" do
      user = build(:user, name: "a" * 11)
      user.valid?
      expect(user.errors[:name]).to include("は10文字以内で入力してください")
    end
    it "メールアドレスがなければ無効な状態であること" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "メールアドレスが50文字以内であれば有効であること" do
      user = build(:user, email: "#{"a" * 38}@example.com")
      expect(user).to be_valid
    end
    it "メールアドレスが51文字以上だと無効であること" do
      user = build(:user, email: "#{"a" * 39}@example.com")
      user.valid?
      expect(user.errors[:email]).to include("は50文字以内で入力してください")
    end
    it "重複したメールアドレスなら無効な状態であること" do
      create(:user, email: "yamada@example.com")
      user = build(:user, email: "yamada@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
    it "メールアドレスに@がないと無効な状態であること" do
      user = build(:user, email: "a" * 20)
      user.valid?
      expect(user.errors[:email]).to include("の形式が間違っています")
    end
    it "パスワードがなければ無効な状態であること" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "パスワードが5文字以上であれば有効であること" do
      user = build(:user, password: "a" * 5)
      expect(user).to be_valid
    end
    it "パスワードが4文字以内だと無効であること" do
      user = build(:user, password: "a" * 4)
      user.valid?
      expect(user.errors[:password]).to include("は5文字以上で入力してください")
    end
  end
end
