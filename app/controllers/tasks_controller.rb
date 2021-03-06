class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # @tasks = Task.where(user_id: current_user.id)
    @tasks = current_user.tasks.recent
  end

  def show
  end

  def new
    @task = Task.new
    # @task = current_user.tasks.new(task_params)
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))
    @task.save!
    redirect_to tasks_url, notice: "タスク\"#{@task.name}\"を登録しました"
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク\"#{@task.name}\"を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク\"#{@task.name}\"を削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
