class RecipeLikesController < ApplicationController
  def create
    @like = current_user.recipe_likes.create(recipe_id: params[:recipe_id])
    flash[:notice] = '投稿に｢いいね！｣しました'
    redirect_to recipe_path(params[:recipe_id])
  end

  def destroy
    @like = RecipeLike.find_by(recipe_id: params[:recipe_id], user_id: current_user.id)
    @like.destroy
    flash[:notice] = '｢いいね！｣を解除しました'
    redirect_to recipe_path(params[:recipe_id])
  end
end
