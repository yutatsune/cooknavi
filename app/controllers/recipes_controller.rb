class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[edit show]
  before_action :move_to_index, except: %i[index show search]

  def index
    @recipes = Recipe.includes(:user).order("created_at DESC")
  end

  def new
    @recipe = Recipe.new
    @recipe.images.new
    @recipe.foodstuffs.new
    @recipe.hows.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "新規投稿しました"
      redirect_to("/recipes")
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

  def edit; end

  def update
    @recipe = Recipe.find(params[:id])
    length = @recipe.images.length
    i = 0
    while i < length
      if recipe_params[:images_attributes][i.to_s]["_destroy"] == "0"
        @recipe.update(recipe_params)
        flash[:notice] = "投稿を編集しました"
        redirect_to recipe_path(params[:id])
        return
      else
        i += 1
      end
    end
    @recipe.update(recipe_params) if recipe_params[:images_attributes][i.to_s]
    render("recipes/edit")
    nil
  end

  def show
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user)
    @like = RecipeLike.new
  end

  def search
    @recipes = Recipe.search(params[:keyword])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :explanation, images_attributes: %i[src _destroy id], foodstuffs_attributes: %i[foodstuff quantity _destroy id], hows_attributes: %i[how _destroy id]).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
