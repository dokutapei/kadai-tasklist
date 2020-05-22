class TasksController < ApplicationController
  before_action :require_user_logged_in

  def index
    @tasks = current_user.tasks
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'tasks/index'
    end
  end
  
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to task_url
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:content, :status)
  end
end