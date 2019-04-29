require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'ユーザーが有効な場合' do
    let(:user) { FactoryBot.build(:alice) }
    it '有効であること' do
      expect(user).to be_valid
    end

    it '保存される前にname属性が小文字に変換されること' do
      user.name = 'ALICE'
      user.save
      expect(user.name).to eq 'alice'
    end
  end
  
  # 有効なファクトリを持つこと 
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
