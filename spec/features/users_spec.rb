require 'rails_helper'

RSpec.feature "Users", type: :feature do
  given(:user) { FactoryBot.create(:yuri) }
    
  scenario '新しいユーザーを作成できること' do
    visit "/"
    click_link "新規登録"
    expect {
      fill_in "Name", with: "takeshi"
      fill_in "Email", with: "takeshi@email.com"
      fill_in "Password", with: "password"
      fill_in "Confirmation", with: "password"
      click_on "Sign up"
    }.to change(User, :count).by(1)
    expect(page).to have_current_path "/login"
  end
  
  scenario 'プロフィールを編集出来ること' do
    login
    click_link "ユーザ編集"
    fill_in "自己紹介文", with: "初めまして"
    click_on "更新する"
    expect(page).to have_content "初めまして"
  end
  
  scenario 'アカウントを削除できること' do
    login
    click_link "ユーザ編集"
    expect {
      click_link "退会する"
    }.to change(User, :count).by(-1)
    expect(page).to have_current_path "/users"
  end
  
  def login
    visit login_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end
