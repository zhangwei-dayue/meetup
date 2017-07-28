require 'rails_helper'

feature "注册和登陆", :type => :feature do
  scenario "register" do
    visit "users/sign_up"

    expect(page).to have_content("Sign up")

    within("#new_user") do
      fill_in "Email", with: "spec@example.com"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"
    end

    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")

    user = User.last
    expect(user.email).to eq("spec@example.com")
  end
end
