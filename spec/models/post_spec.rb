require 'rails_helper'

RSpec.describe Post, type: :model do
  context "バリデーション" do
    it "投稿内容とユーザーidがあれば有効な状態であること" do
      post = create(:post)
      expect(post).to be_valid
    end
    it "投稿内容がなければ無効な状態であること" do
      post = build(:post, content: nil)
      post.valid?
      expect(post.errors[:content]).to include("を入力してください")
    end
    it "投稿内容が500文字以内であること" do
      post = build(:post, content: "a" * 500)
      expect(post).to be_valid
    end
    it "投稿内容が501文字以上の場合無効であること" do
      post = build(:post, content: "a" * 501)
      post.valid?
      expect(post.errors[:content]).to include("は500文字以内で入力してください")
    end
  end
end
