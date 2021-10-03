class CommentsController < ApplicationController

  def create
    task = Task.find(params[:task_id])
    comment = current_user.task_comments.new(comment_params)
    comment.task_id = task.id
    comment.save
    @task = Task.find(params[:task_id])
    @comment = Comment.new
    # 通知機能実装の為のレコード
    @task.create_notification_by(current_user)
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
