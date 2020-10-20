class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @recipes = Recipe.includes(:user)
  end

  def new
    @recipe = Recipe.new
    @recipe.images.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "新規投稿しました"
      redirect_to("/")
    else
      render("recipes/new")
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/")
  end

  def edit
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to("/")
    else
      render("recipes/edit")
    end
  end

  def show
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user)
  end

  def search
    @recipes = Recipe.search(params[:keyword])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :image, :text, :material, images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
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
