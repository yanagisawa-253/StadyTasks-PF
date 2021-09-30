class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.save
    flash[:notice] = 'タスクが投稿されました'
    redirect_to tasks_path
  end

  def update
    @task = Task.find(params[:id])
    if  @task.update(task_params)
      redirect_to tasks_path
    else
      render 'index'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    redirect_to task_path(@task)
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :status)
  end
end
