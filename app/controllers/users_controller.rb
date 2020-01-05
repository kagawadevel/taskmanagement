class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  before_action :current_user?, only: [:show, :edit, :update]


  def index
  end

  def show
  end

  def new
    if session[:user_id] != nil
      redirect_to user_path(session[:user_id]), notice: 'すでにユーザーが作成されています'
    else
    @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "ユーザーを作成しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user?
    redirect_to user_path(current_user.id), notice: 'ユーザーが違います' unless current_user == User.find(params[:id])
  end

end
