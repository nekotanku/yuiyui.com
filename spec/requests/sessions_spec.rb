require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { FactoryBot.create(:yuri) }
  
  describe 'POST #create' do
    context 'remember me有りのログイン' do
      it 'remembers cookies' do
        post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                      remember_me: '1'} }
        expect(response.cookies['remember_token']).to_not eq nil
      end
    end
    
    context 'remember me無しのログイン' do
      it 'dosent remembers cookies' do
        post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                      remember_me: '1'} }
        delete logout_path
        post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                      remember_me: '0'} }
        expect(response.cookies['remember_token']).to eq nil
      end
    end
  end
end