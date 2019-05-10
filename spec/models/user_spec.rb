require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'ユーザーが有効な場合' do
    let(:user) { FactoryBot.build(:yuri) }
    it '有効であること' do
      expect(user).to be_valid
    end
    it "アバターの拡張子がjpg, jpeg, gif, pngであれば有効であること" do
      formats = %w(jpg jpeg gif png)
      formats.each do |format|
        image_path = File.join(Rails.root, "spec/fixtures/test.#{format}")
        user = FactoryBot.build(:yuri, avater: File.open(image_path))
        expect(user).to be_valid
      end
    end
  end
    
  describe 'ユーザーが無効な場合' do
    let(:user) { FactoryBot.build(:yuri) }
    context 'ユーザー名に対するバリデーション' do
      before do 
        FactoryBot.create(:taro)
      end
      it 'ユーザー名が存在しない場合無効であること' do
        user.name = nil
        expect(user).to_not be_valid
      end
      it 'ユーザー名が20文字以上の場合無効であること' do
        user.name = 'a' * 21
        expect(user).to_not be_valid
      end
      it 'ユーザー名が既に存在している場合無効であること' do
        user.name = 'taro'
        expect(user).to_not be_valid
      end
    end
    
    context 'パスワードに対するバリデーション' do
      before do 
        FactoryBot.create(:taro)
      end
      it 'パスワードが存在しない場合無効であること' do
        user.password = nil
        expect(user).to_not be_valid
      end
    end
    
    context 'メールアドレスに対するバリデーション' do
      before do
        FactoryBot.create(:taro)
      end
      it 'メールアドレスに@が含まれていない場合無効であること' do
        user.email = 'yuri.com' 
        expect(user).to_not be_valid
      end

      it 'メールアドレスが存在しない場合無効であること' do
        user.email = nil
        expect(user).to_not be_valid
      end

      it 'メールアドレスが既に存在している場合無効であること' do
        user.email = 'taro@email.com'
        expect(user).to_not be_valid
      end
    end
    
    context '自己紹介に対するバリデーション' do
      it '自己紹介が200文字以上の場合無効であること' do
        user.introduce = 'a' * 201
        expect(user).to_not be_valid
      end
    end
    
    context 'アバターに対するバリデーション' do
      it "拡張子がjpg, jpeg, gif, png以外であれば無効" do
        image_path = File.join(Rails.root, "spec/fixtures/test.rb")
        user = FactoryBot.build(:yuri, avater: File.open(image_path))
        expect(user).not_to be_valid
      end
    end
  end
  
  describe '検索機能のテスト' do
    let(:user) { FactoryBot.create(:yuri) }
    it '存在しないユーザ名で検索をかけても、ユーザは出力されないこと' do
      expect(User.search('satoshi')). to_not include(user)
    end
    it 'ユーザ名で検索をかけたら、該当するユーザを出力すること' do
      expect(User.search('yuri')).to include(user)
    end
  end
  
  describe 'followingの関連メソッドのテスト' do
    let(:user) { FactoryBot.create(:yuri) }
    let(:other_user) { FactoryBot.create(:taro) }
    it 'follow/unfollowできること' do
      expect(user.following?(other_user)).to be false
      user.follow(other_user)
      expect(user.followings).to include(other_user)
      expect(user.following?(other_user)). to be true
      user.unfollow(other_user)
      expect(other_user.followers). to_not include(user)
    end
    it 'ユーザ自身をfollowできないこと' do
      user.follow(user)
      expect(user.followings). to_not include(user)
    end
  end
  
  describe 'authenticated?のテスト' do
    let!(:user) { FactoryBot.create(:yuri) }
    it 'remember_digestが存在しなければ無効であること' do
      expect(user.authenticated?(remember_token: '')).to eq false
    end
  end
  
  
end