require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "バリデーション" do
    it "コメント内容とユーザーid、投稿idがあれば有効な状態であること" do
      comment = create(:comment)
      expect(comment).to be_valid
    end
    it "コメント内容がなければ無効な状態であること" do
      comment = build(:comment, content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include("を入力してください")
    end
    it "コメント内容が255文字以内であること" do
      comment = build(:comment, content: "a" * 255)
      expect(comment).to be_valid
    end
    it "コメント内容が256文字以上の場合無効であること" do
      comment = build(:comment, content: "a" * 256)
      comment.valid?
      expect(comment.errors[:content]).to include("は255文字以内で入力してください")
    end
  end
end
