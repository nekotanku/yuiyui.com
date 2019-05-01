module SessionSupport
  def sign_in_as(user)
    visit login_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end

RSpec.configure do |config|
  config.include SessionSupport
end