require 'rails_helper'

feature "查看所有活动", :type => :feature do

  before do
    @user = User.create!( :email => "spec@example.com", :password => "123456" )
    @event1 = Event.create!( :title => "event1", :description => "text1", :user_id => @user.id)
    @event2 = Event.create!( :title => "event2", :description => "text2", :user_id => @user.id)
  end

  scenario "查看所有活动" do
    visit "/events"
    sign_in(@user)

    expect(page).to have_content("text1", "text2")
  end

  scenario "添加新活动" do
    visit "/events"
    sign_in(@user)

    click_link "添加新活动"

    expect(page).to have_content("添加新活动", "名称", "简介")

    within("#new_event") do
      fill_in "名称", with: "event_test1_title"
      fill_in "简介", with: "event_test1_description"
    end

    click_button "提交"

    expect(page).to have_content("event_test1_title", "event_test1_description")

    event = Event.last
    expect(event.title).to eq("event_test1_title")
  end

  scenario "添加新活动失败" do
    visit "/events"
    sign_in(@user)

    click_link "添加新活动"

    expect(page).to have_content("添加新活动", "名称", "简介")

    within("#new_event") do
      fill_in "简介", with: "event_test1_description"
    end

    click_button "提交"

    expect(page).to have_content("can't be blank")
  end

  scenario "查看单一活动页面" do
    visit "/events"
    sign_in(@user)

    click_link "event1"

    expect(page).to have_content("event1", "text1", "发表评论")
  end

end
