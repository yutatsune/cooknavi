class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:follow])
    current_user.follow(@other_user)
  end

  def destroy
    @user = current_user.relationships.find(params[:id]).follow
    current_user.unfollow(params[:id])
  end
end
