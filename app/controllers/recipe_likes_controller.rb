class RecipeLikesController < ApplicationController
  def create
    if current_user.recipe_like_this(clicked_recipe)
      flash[:notice] = '投稿に｢いいね！｣しました'
      redirect_to root_path
    else
      flash[:notice] = 'すでに｢いいね！｣しています'
      redirect_to root_path
    end
  end

  def destroy
    current_user.recipe_likes.find_by(recipe_id: params[:recipe_id]).destroy
    flash[:notice] = '｢いいね！｣を解除しました'
    redirect_to root_path
  end
  
  private
  def clicked_recipe
    Recipe.find(params[:recipe_id])
  end
  
end
