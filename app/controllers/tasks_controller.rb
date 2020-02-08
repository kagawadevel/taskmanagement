class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  #before_action :not_current_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :currentuser_id, only: [:index]

  def index
    current_user_id = @current_user_id
    @tasks = Task.currentuser_task(current_user_id).order('created_at DESC').page(params[:page]).per(10)
    @labels = Label.where(user_id: current_user_id)

    if params[:sort_expired]
      @tasks = Task.all.sort_expired_asc.page(params[:page]).per(10)
    end

    if params[:sort_priority]
      @tasks = current_user.tasks.sort_priority_asc.page(params[:page]).per(10)
    end

    if params[:task] && params[:task][:search]
      #binding.pry
      if params[:task][:title].present? && params[:task][:status].present?
        #タイトルもステータスもある場合
        #binding.pry
        @tasks = current_user.tasks.title_search(params[:task][:title]).status_search(params[:task][:status]).page(params[:page]).per(10)
      elsif params[:task][:title].empty? && params[:task][:status].present?
        #タイトルが無く、ステータスはある場合
        #binding.pry
        @tasks = current_user.tasks.status_search(params[:task][:status]).page(params[:page]).per(10)
      elsif params[:task][:title].present? && params[:task][:status] == ""
        #タイトルがあり、ステータスは無い場合
        #binding.pry
        @tasks = current_user.tasks.title_search(params[:task][:title]).page(params[:page]).per(10)
      elsif params[:task][:label_ids].present?
        #binding.pry
        @tasks = current_user.tasks.joins(:task_labels).where('task_labels.label_id = ?', params[:task][:label_ids]).page(params[:page]).per(10)
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
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] ='タスクを作成しました'
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] ='タスクを更新しました'
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render 'new' if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :limit, :status, :search, :priority, label_ids: [] )
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def currentuser_id
    @current_user_id = current_user.id
  end

  #{#def not_current_user
      # @task = Task.find(params[:id])
      #redirect_to new_session_path, notice: 'ユーザーが違います' unless current_user.id == @task.user_id
      #end}"
end
