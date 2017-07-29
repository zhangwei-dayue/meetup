class Api::V1::CommentsController < ApiController

  def create
    @event = Event.find(params[:event_id])
    @comment = Comment.new(:event_id => @event.id,
                           :name => params[:name],
                           :body => params[:body])
    if @comment.save
      render :json => {
        :comment_url => api_v1_comment_url(@comment.id)
      }
    else
      render :json => { :message => "发表评论失败", :errors => @comment.errors }, :status => 400
    end
  end

  def show
    @comment = Comment.find(params[:comment_id])

    render :json => {
      :name => @comment.name,
      :body => @comment.body
    }
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy

    render :json => {:message => "已删除评论"}
  end

end
