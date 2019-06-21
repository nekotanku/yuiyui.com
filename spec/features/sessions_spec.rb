require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  given(:user) { FactoryBot.create(:yuri) }

  scenario 'ログイン出来ること' do
    visit "/"
    login
    expect(page).to have_current_path '/posts'
  end

  scenario 'ログアウト出来ること' do
    visit "/"
    login
    click_on 'ログアウト'
    expect(page).to have_current_path '/'
  end

  def login
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button "ログインする"
  end
end
