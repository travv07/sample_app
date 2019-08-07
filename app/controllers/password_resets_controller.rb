class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "password_resets.new.send_email"
      redirect_to root_path
    else
      flash.now[:danger] = t "password_resets.new.not_find_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("password_resets.edit.cant_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t "password_resets.edit.pass_reseted"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by(email: params[:email])
    return if @user
    flash[:danger] = t "shared.error_messages.notfound"
    redirect_to notfound_path
  end

  def valid_user
    unless @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "password_resets.edit.password_expired"
      redirect_to new_password_reset_url
    end
  end
end
