class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    #投稿に紐づいたコメントを作成
    @comment = @task.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    
    # 通知機能実装の為のレコード作成
    @task.create_notification_by(current_user)
    render 'index'
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    redirect_to task_path(params[:task_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :task_id, :user_id)
  end
end
