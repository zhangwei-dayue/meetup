class CommentsController < ApplicationController
  before_action :authenticate_user! only: [:create, :destroy]
  before_action :find_event

  def create
    @comment = @event.comments.create(params[:comment].permit(:name, :body))
    redirect_to event_path(@event)
  end

  def destroy
    @comment = @event.comments.find(params[:id])
    @comment.destroy
    redirect_to event_path(@event)
  end

  protected

  def find_event
    @event = Event.find(params[:event_id])
  end
end
