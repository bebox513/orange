require 'rails_helper'

RSpec.describe Message, type: :model do
  it "メッセージが1000文字以内であること" do
    message = build(:message, content: "a" * 1000)
    expect(message).to be_valid
  end
  it "メッセージが1001文字以上の場合無効であること" do
    message = build(:message, content: "a" * 1001)
    message.valid?
    expect(message.errors[:content]).to include("は1000文字以内で入力してください")
  end
end
