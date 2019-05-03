require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:yuri) }
  
  describe "GET #show" do
    it "ログインしなければログインページにリダイレクトすること" do
      get user_path(user)
      expect(response).to redirect_to login_path
    end
  end
end
