class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_event

  def create
    @comment = @event.comments.new(params[:comment].permit(:name, :body))
    @comment.user = current_user
    if @comment.save
      redirect_to event_path(@event)
    else
      redirect_to event_path(@event), alert: "未发表成功"
    end
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
