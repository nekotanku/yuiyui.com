require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe 'POST #create' do
    before do
      @user = FactoryBot.create(:yuri)
      @post = FactoryBot.create(:yuri_post, user: @user)
      @like_params = FactoryBot.attributes_for(:like)
    end
    it 'ログインしていないユーザーは「いいね」出来ないこと' do
      post likes_path(@post, @user.likes.build), params: @like_params
      expect(response).to redirect_to login_url
    end
  end
end
