require 'rails_helper'

RSpec.describe "API_V1::Events", :type => :request do

  before do
    @event1 = Event.create!( :title => "test1", :description => "description1", :detail => "detail1")
    @event2 = Event.create!( :title => "test2", :description => "description2", :detail => "detail2")
  end

  example "查看活动列表" do
    get "/api/v1/events"

    expect(response).to have_http_status(200)

    expected_result = {
      "data": [
        { "title": @event1.title,
          "description": @event1.description,
          "event_url": api_v1_event_url(@event1.id)},
        { "title": @event2.title,
          "description": @event2.description,
          "event_url": api_v1_event_url(@event2.id)},
      ]
    }
    expect(response.body).to eq( expected_result.to_json )
  end

  example "查看单一活动页面" do
    get "/api/v1/events/1"

    expect(response).to have_http_status(200)

    expected_result = { "title": @event1.title,
          "description": @event1.description,
          "detail": @event1.detail}

    expect(response.body).to eq( expected_result.to_json )
  end

end
