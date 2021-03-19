require 'rails_helper'

RSpec.describe Room, type: :model do
  context "バリデーション" do
    it "ルームネームがあれば有効な状態であること" do
      room = create(:room)
      expect(room).to be_valid
    end
    it "ルームネームが10文字以内であること" do
      room = build(:room, name: "a" * 10)
      expect(room).to be_valid
    end
    it "ルームネームが11文字以上の場合無効であること" do
      room = build(:room, name: "a" * 11)
      room.valid?
      expect(room.errors[:name]).to include("は10文字以内で入力してください")
    end
  end
end
