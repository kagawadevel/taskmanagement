class SessionsController < ApplicationController

  def new
    if session[:user_id] != nil
      redirect_to user_path(session[:user_id]), notice: 'すでにログインしています'
    end
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: 'ログアウトしました'
  end
end
