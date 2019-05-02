require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  given(:user) { FactoryBot.create(:yuri) }
  given!(:other_user) { FactoryBot.create(:taro) }
  
  background do
    visit login_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
  
  feature 'まだフォローをしていない場合' do
    scenario 'フォローできること' do
      visit users_path
      click_link other_user.name
      expect {
        click_on "Follow"
      }.to change(Relationship, :count).by(1)
      expect(page).to have_button 'Unfollow'
    end
  end
  feature 'すでにフォローしていること' do
    background do
      user.follow(other_user)
    end
    scenario 'フォロー解除できること' do
      visit users_path
      click_link other_user.name
      expect {
        click_on "Unfollow"
      }.to change(Relationship, :count).by(-1)
      expect(page).to have_button 'Follow'
    end
  end
end
