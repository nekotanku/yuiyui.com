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
    it 'contentが200文字を超えること' do
      post.content = 'a' * 201
      expect(post).to_not be_valid
    end
  end
  
  describe '検索機能のテスト' do
    let(:post) { FactoryBot.create(:yuri_post) }
    it '存在しないキーワードで検索をかけても、postは出力されないこと' do
      expect(Post.search('犬')). to_not include(post)
    end
    it '記事に関連するキーワードで検索をかけたら、該当するpostを出力すること' do
      expect(Post.search('猫')).to include(post)
    end
  end
  
  describe 'likes関連メソッドのテスト' do
    let(:post) { FactoryBot.create(:yuri_post) }
    let(:current_user) { FactoryBot.create(:taro) }
    it 'like/unlikeできること' do
      expect(post.like?(current_user)).to be false
      post.like(current_user)
      expect(post.like?(current_user)).to be true
      expect(post.like_users).to include(current_user)
      post.unlike(current_user)
      expect(current_user.likes).to_not include(post)
      expect(post.like_users).to_not include(current_user)
    end
  end
  
  
end