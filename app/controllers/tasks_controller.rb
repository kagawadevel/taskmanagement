class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order('created_at DESC')

    if params[:sort_expired]
      @tasks = Task.all.order(limit: :desc)
    end

    if params[:task] && params[:task][:search]
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.where("title LIKE ?", "%#{ params[:task][:title] }%").where(status: params[:task][:status])
      elsif params[:task][:title].empty? && params[:task][:status].present?
        @test = "テスト成功"
        #binding.pry
        #@tasks = Task.where(status: params[:task][:status])
      elsif params[:task][:title].present? && params[:task][:status] == ""
        @tasks = Task.where("title LIKE ?", "%#{ params[:task][:title] }%")
      end
    end
  end

  def show
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task = Task.update(task_params)
      redirect_to tasks_path, notice: "タスクを更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  def confirm
    @task = Task.new(task_params)
    render 'new' if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :status, :search, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
