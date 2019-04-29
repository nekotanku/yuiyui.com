require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post){ FactoryBot.build(:yuri_post) }
  describe '投稿が有効な場合' do
    it '有効であること' do
      expect(post).to be_valid
    end
  end
  
  
  describe '投稿が無効な場合' do
    it 'contentが空であること' do
      post.content = ""
      post.valid?
      expect(post.errors[:content]).to include("can't be blank")
    end
  end
end