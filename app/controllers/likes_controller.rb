class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.find(params[:id])
    Like.create(user_id: current_user.id, task_id: params[:id])
    redirect_to task_path(@task)
    #通知作成

  end

  def destroy
    @task = Task.find(params[:task_id])
    @favorite = TaskLike.find_by(
      user_id: current_user.id,
      task_id: @task
    )
    @like.destroy
  end
  # def destroy
  #   task = Task.find(params[:id])
  #   Like.find_by(user_id: current_user.id, task_id: params[:id]).destroy
  #   redirect_to task_path(task)
  # end
end
