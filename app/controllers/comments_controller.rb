class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.task_id = params[:task_id]
    @comment.user_id = current_user.id
    @comment_task = @comment.task
    if @comment.save
      @task = @comment.task
      @task.create_notification_comment!(current_user, @comment.id)
      redirect_to task_path(@task)
    else
      flash.now[:danger] = 'コメントを入力してください。'
      render 'show'
    end
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    flash[:notice] = " コメントを削除しました"
    redirect_to task_path(params[:task_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :task_id, :user_id)
  end

end