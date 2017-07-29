require 'rails_helper'

feature "注册和登陆", :type => :feature do
  scenario "注册" do
    visit "/users/sign_up"

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

  scenario "注册失败" do
    visit "/users/sign_up"

    expect(page).to have_content("Sign up")

    within("#new_user") do
      fill_in "Email", with: "spec@example.com"
    end

    click_button "Sign up"

    expect(page).to have_content("can't be blank")

  end

  scenario "登陆和退出" do
    user = User.create!(:email => "spec@example.com", :password => "123456")

    visit "/users/sign_in"

    expect(page).to have_content("Log in")

    within("#new_user") do
      fill_in "Email", with: "spec@example.com"
      fill_in "Password", with: "123456"
    end

    click_button "Log in"

    expect(page).to have_content("Signed in successfully")

    # click_link "Hi!,spec@example.com"
    page.find(:xpath, "//a[@href='/users/sign_out']").click
    # click_link "退出"

    expect(page).to have_content("Signed out successfully")
  end

  scenario "登陆失败" do
    user = User.create!(:email => "spec@example.com", :password => "123456")

    visit "/users/sign_in"

    expect(page).to have_content("Log in")

    within("#new_user") do
      fill_in "Email", with: "spec1@example.com"
      fill_in "Password", with: "123456"
    end

    click_button "Log in"

    expect(page).to have_content("Invalid Email or password")

  end
end
