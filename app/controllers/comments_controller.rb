class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:success] = 'コメントしました。'
      @task = @comment.task
      @task.create_notification_comment!(current_user, @comment.id)
      render 'show'
      # redirect_to task_path(@task)
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

  # def create
  #   #通知作成
  #   @postimage = @comment.post_image
  #   @postimage.create_notification_post_image_comment!(current_user, @comment.id)
  #   end

  # def destroy
  #   @postimagecomment = PostImageComment.find(params[:post_image_id])
  #   @postimagecomment.post_image.id = @postimagecomment.post_image_id
  #   @postimage = @postimagecomment.post_image
  #   @postimagecomment.destroy
  #   end
