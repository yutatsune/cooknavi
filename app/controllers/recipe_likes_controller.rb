class RecipeLikesController < ApplicationController
  before_action :set_recipe

  def create
    @like = current_user.recipe_likes.new(recipe_id: @recipe.id)
    @like.save
    @likes = RecipeLike.where(recipe_id: @recipe.id)
  end

  def destroy
    @like = RecipeLike.find_by(recipe_id: @recipe.id, user_id: current_user.id).destroy
    @likes = RecipeLike.where(recipe_id: @recipe.id)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
