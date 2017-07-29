require 'rails_helper'

RSpec.describe "API_V1::Comments", :type => :request do

  before do
    @event1 = Event.create!( :title => "test1", :description => "description1", :detail => "detail1")
    @event2 = Event.create!( :title => "test2", :description => "description2", :detail => "detail2")

    @user = User.create!( :email => "spec@example.com", :password => "123456" )
    @comment = Comment.create!( :event_id => @event1.id, :name => "报名",
                                        :body => "期待明天的meetup" )
  end

  example "查看comment单一页面" do
    get "/api/v1/comments/#{@comment.id}"

    expect(response).to have_http_status(200)
    expect(response.body).to eq( {
                                   :name => "报名",
                                   :body => "期待明天的meetup"
                                  }.to_json )
  end

  example "删除评论" do
    delete "/api/v1/comments/#{@comment.id}"

    expect(response).to have_http_status(200)

    expect(response.body).to eq( { :message => "已删除评论" }.to_json )
    expect( Comment.count ).to eq(0)
  end

end
