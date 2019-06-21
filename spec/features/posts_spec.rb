require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  given(:user) { FactoryBot.create(:yuri) }
  given(:other_user) { FactoryBot.create(:taro) }
  given!(:post) { FactoryBot.create(:yuri_post, user: user) }
  given!(:other_post) { FactoryBot.create(:taro_post, user: other_user) }

  feature '記事を投稿する場合' do
    scenario '文字のみの記事を投稿できること' do
      login(user)
      visit new_post_path
      expect {
        fill_in "post[content]", with: "ハロー世界"
        click_on "投稿"
      }.to change(Post, :count).by(1)
      expect(page).to have_text "ハロー世界"
    end

  end

  feature '記事を編集する場合' do
    scenario 'Post製作者のみ編集できること' do
      login(user)
      visit posts_path
      click_link post.content
      click_link "編集"
      fill_in "post[content]", with: "ハロー編集"
      click_on "更新する"
      expect(page).to have_text "ハロー編集"
    end

    scenario 'Post製作者以外は編集できないこと' do
      login(other_user)
      visit posts_path
      click_link post.content
      expect(page).to have_no_link "編集"
    end
  end

  scenario '記事を削除できること' do
    login(user)
    visit posts_path
    click_link post.content
    expect {
      click_link "削除"
    }.to change(Post, :count).by(-1)
    expect(page).to have_current_path "/posts"
  end

  scenario '記事を検索できること(content検索)' do
    visit posts_path
    fill_in 'search', with: post.content
    click_on "記事検索"
    expect(page).to have_content post.content
    expect(page).to have_no_content other_post.content
  end


  def login(user)
    visit login_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログインする"
  end
end
