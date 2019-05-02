require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  given(:user) { FactoryBot.create(:yuri) }
  given(:other_user) { FactoryBot.create(:taro) }
  given!(:post) { FactoryBot.create(:taro_post, user: other_user) }
  
  background do
    visit login_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
  
  feature 'まだいいねをしていない場合' do
    scenario 'いいねできること' do
      visit posts_path
      click_link post.content
      expect {
        click_on "いいね"
      }.to change(Like, :count).by(1)
      expect(page).to have_button 'いいね済み'
    end
  end
  feature 'すでにいいねをしている場合' do
    background do
      post.like(user)
    end
    
    scenario 'いいね解除できること' do
      visit posts_path
      click_link post.content
      expect {
        click_on "いいね済み"
      }.to change(Like, :count).by(-1)
      expect(page).to have_button 'いいね'
    end
  end
end
