class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.task_id = params[:task_id]
    # @task = Task.find(params[:task_id])
    # @comment = @task.comments.new(comment_params)
    # @comment.user_id = current_user.id
    if @comment.save
      @task = @comment.task
      @task.create_notification_comment!(current_user, @comment.id)
      redirect_to task_path(@task)
    else
      flash.now[:danger] = 'コメントを入力してください。'
      render 'show'
      # redirect_to post_path(@post)
    end
  end

  # def create
  #   task = Task.find(params[:task_id])
  #   comment = current_user.comments.new(comment_params)
  #   comment.task_id = task.id
  #   comment.save
  #   task.create_notification_comment!(current_user, comment.id)
  #   redirect_to task_path(task)
  # end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    flash[:notice] = " 投稿を削除しました"
    redirect_to task_path(params[:task_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :task_id, :user_id)
  end
end