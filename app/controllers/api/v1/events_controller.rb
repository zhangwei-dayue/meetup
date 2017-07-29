class Api::V1::EventsController < ApiController

  def index
    @events = Event.all
    render :json => {
      :data => @events.map { |event|
        {:title => event.title,
          :description => event.description,
          :event_url => api_v1_event_url(event.id)
        }
      }
    }
  end

  def show
    @event = Event.find(params[:event_id])

    render :json => {
      :title => @event.title,
      :description => @event.description,
      :detail => @event.detail
    }
  end
end
