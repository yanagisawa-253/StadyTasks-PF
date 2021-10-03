class LikesController < ApplicationController

  def create
      like = current_user.likes.new(task_id: @task.id)
      like.save
      @task = Task.find(params[:task_id])
      #通知の作成
      @task.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
  end

  # def create
  #   task = Task.find(params[:id])
  #   Like.create(user_id: current_user.id, task_id: params[:id])
  #   # 通知レコードの作成

  #   task.create_notification_like!(current_user)

  #   redirect_to task_path(task)
    # task = Task.find(params[:id])
    # like = current_user.likes.new(task_id: task.id)
    # like.save
    # redirect_to task_path(task)
  # end

  def destroy
    task = Task.find(params[:id])
    Like.find_by(user_id: current_user.id, task_id: params[:id]).destroy
    redirect_to task_path(task)
  end
end
