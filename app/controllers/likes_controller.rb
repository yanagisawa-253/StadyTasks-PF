class LikesController < ApplicationController

  def create
    task = Task.find(params[:id])
    Like.create(user_id: current_user.id, task_id: params[:id])
    redirect_to task_path(task)
    # task = Task.find(params[:id])
    # like = current_user.likes.new(task_id: task.id)
    # like.save
    # redirect_to task_path(task)
  end

  def destroy
    task = Task.find(params[:id])
    Like.find_by(user_id: current_user.id, task_id: params[:id]).destroy
    redirect_to task_path(task)
  end
end
