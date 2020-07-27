class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    Recipe.create(recipe_params)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
  end

  def edit
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
  end

  def show
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :image, :text)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
