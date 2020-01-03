class Administrator::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :destroy]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to administrator_users_path, notice: 'ユーザーを作成しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @user = User.new(user_params)
    if @user.save
      redirect_to administrator_users_path, notice: 'ユーザーを編集しました'
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to administrator_users_path, notice: "ユーザーを削除しました"
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
