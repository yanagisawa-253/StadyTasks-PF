class CommentsController < ApplicationController

  def create
    task = Task.find(params[:task_id])
    comment = current_user.comments.new(comment_params)
    comment.task_id = task.id
    comment.save
    task.create_notification_comment!(current_user, @comment.id)
    redirect_to task_path(task)
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    redirect_to task_path(params[:task_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
