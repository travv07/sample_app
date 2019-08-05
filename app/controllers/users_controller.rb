class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:danger] = t "shared.error_messages.notfound"
    redirect_to notfound_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new param_users
    if @user.save
      flash[:success] = t "static_pages.home.title_page_message"
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  private
  def param_users
    params.require(:user).permit(:name, :email,
      :password, :password_confirmation)
  end
end
