require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET #new' do
    it 'ログインしていない場合ログインページにリダイレクトされること' do
      get new_post_path
      expect(response).to redirect_to login_url
    end
  end
end
