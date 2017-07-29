require 'rails_helper'

feature "发表评论", :type => :feature do
  before do
    @user = User.create!( :email => "spec@example.com", :password => "123456" )
    @event1 = Event.create!( :title => "event1", :description => "text1", :user_id => @user.id)
    @event2 = Event.create!( :title => "event2", :description => "text2", :user_id => @user.id)
  end

  scenario "发表评论" do
    visit "/events"
    sign_in(@user)

    click_link "event1"

    expect(page).to have_content("event1", "text1", "发表评论")

    within("#new_comment") do
      fill_in "标题", with: "comment_test1_name"
      fill_in "内容", with: "comment_test1_body"
    end

    click_button "提交"

    expect(page).to have_content("comment_test1_name", "comment_test1_body")
  end

  scenario "发表评论未成功" do
    visit "/events"
    sign_in(@user)

    click_link "event1"

    expect(page).to have_content("event1", "text1", "发表评论")

    within("#new_comment") do
      fill_in "内容", with: "comment_test1_body"
    end

    click_button "提交"

    expect(page).to have_content("未发表成功")
  end
end
