class RecipeLikesController < ApplicationController
  def create
    @like = current_user.recipe_likes.new(recipe_id: clicked_recipe.id)
    
  end

  private
  def clicked_recipe
    Recipe.find(params[:recipe_id])
  end
end
