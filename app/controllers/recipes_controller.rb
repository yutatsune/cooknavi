class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  def index
    @recipes = Recipe.includes(:user)
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
    params.require(:recipe).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
