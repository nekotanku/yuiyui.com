require 'rails_helper'

RSpec.feature "Users", type: :feature do
  given(:user) { FactoryBot.create(:yuri) }
  given(:other_user){ FactoryBot.create(:taro) }

  scenario '新しいユーザーを作成できること' do
    visit "/"
    click_link "新規登録"
    expect {
      fill_in "お名前", with: "takeshi"
      fill_in "メールアドレス", with: "takeshi@email.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワードの確認", with: "password"
      click_on "Sign up"
    }.to change(User, :count).by(1)
    expect(page).to have_current_path "/login"
  end
  feature 'プロフィールを編集する場合' do
    background do
      login
      click_link "マイプロフィール"
      click_link "ユーザ編集"
    end

    scenario '自己紹介文を編集できること' do
      fill_in "自己紹介文", with: "初めまして"
      click_on "更新する"
      expect(page).to have_content "初めまして"
    end
    scenario 'アバターを編集できること' do
      attach_file "user[avater]", "#{Rails.root}/spec/fixtures/test.png"
      click_on "更新する"
      expect(page).to have_content "プロフィールを編集しました"
    end
  end


  scenario 'アカウントを削除できること' do
    login
    click_link "マイプロフィール"
    click_link "ユーザ編集"
    expect {
      click_link "退会する"
    }.to change(User, :count).by(-1)
    expect(page).to have_current_path "/users"
  end

  scenario 'ユーザを検索できること' do
    visit users_path
    fill_in 'search', with: user.name
    click_on "ユーザー検索"
    expect(page).to have_content user.name
    expect(page).to_not have_content other_user.name
  end

  def login
    visit login_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログインする"
  end
end
