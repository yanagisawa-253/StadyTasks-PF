class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]

  def index
    @tasks = Task.page(params[:page]).reverse_order
    @like = Like.new
  end

  def show
    @task = Task.find(params[:id])
    @user = @task.user
    @comment = Comment.new
    @comments = @task.comments.order(created_at: :desc)
    @like = Like.new
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
    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if  @task.update(task_params)
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :body, :status)
  end

end