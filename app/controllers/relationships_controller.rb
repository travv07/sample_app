class RelationshipsController < ApplicationController
  before_action :load_user, only: :create
  before_action :load_relationship_follower, only: :destroy

  def create
    current_user.follow @user
    respond_to do |f|
      f.html {redirect_to @user}
      f.js
    end
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user
    respond_to do |f|
      f.html {redirect_to @user}
      f.js
    end
  end

  private

  def load_user
    @user = User.find_by(id: params[:followed_id])
    unless @user
      flash.now[:danger] = t "shared.error_messages.notfound"
      redirect_to notfound_path
    end
  end

  def load_relationship_follower
    @relationship = Relationship.find_by(id: params[:id])
    unless @relationship
      flash.now[:danger] = t "shared.error_messages.notfound"
      redirect_to notfound_path
    end
  end

end
