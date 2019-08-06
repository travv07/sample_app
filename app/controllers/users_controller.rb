class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :create, :new]
  before_action :find_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.all.paginate(page: params[:page],
      per_page: Settings.controller.per_page)
  end

  def show ;end

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

  def edit; end

  def update
    if @user.update_attributes param_users
      flash[:success] = t "users.edit.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.index.delete_success"
      redirect_to users_url
    else
      flash[:danger] = t "shared.error_messages.notfound"
      redirect_to notfound_path
    end
  end

  private

  def param_users
    params.require(:user).permit(:name, :email,
      :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "users.edit.request_login"
      redirect_to login_path
    end
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:danger] = t "shared.error_messages.notfound"
    redirect_to notfound_path
  end
end
