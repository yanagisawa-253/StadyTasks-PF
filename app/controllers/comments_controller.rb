class CommentsController < ApplicationController

  # def create
  #   @comment = current_user.comments.build(comment_params)
  #   @comment.task_id = params[:task_id]
  #   @comment.user_id = current_user.id
  #   @comment_task = @comment.task
  #   if @comment.save
  #     @task = @comment.task
  #     @task.create_notification_comment!(current_user, @comment.id)
  #     redirect_to task_path(params[:task_id])
  #   else
  #     flash.now[:danger] = 'コメントを入力してください。'
  #     render 'show'
  #   end
  # end
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.task_id = params[:task_id]
    if @comment.save
      #通知機能用
      @task = @comment.task
      @task.create_notification_comment!(current_user, @comment.id)
      #ここまで通知機能
      redirect_to @comment.task
    else
      comments_get
      render 'show'
    end
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