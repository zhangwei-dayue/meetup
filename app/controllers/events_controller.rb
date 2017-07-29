class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to events_path, alert: "添加活动成功"
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if !current_user = @event.user
      redirect_to events_path, alert: "你没有修改的权限"
    else
      if @event.update(event_params)
        redirect_to events_path, alert: "编辑活动成功"
      else
        render :edit
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if !current_user = @event.user
      redirect_to events_path, alert: "你没有修改的权限"
    else
      @event.destroy
      redirect_to events_path
    end
  end

  protected

  def event_params
    params.require(:event).permit(:title, :description, :user_id, :detail)
  end
end
