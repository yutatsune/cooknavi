class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[edit show]
  before_action :move_to_index, except: %i[index show search]
  before_action :set_q, only: %i[index search]

  def index
    @recipes = Recipe.includes(:user).order("created_at DESC").page(params[:page]).per(9)
    @all_ranks = Recipe.create_recipe_ranks
  end

  def new
    @recipe = Recipe.new
    @recipe.images.new
    @recipe.foodstuffs.new
    @recipe.hows.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    tag_list = params[:recipe][:tag_name].split(',')
    if @recipe.save
      @recipe.save_recipes(tag_list)
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

  def edit
    @tag_list = @recipe.tags.pluck(:tag_name).join(",")
  end

  def update
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:tag_name).join(",")
    tag_list = params[:recipe][:tag_name].split(',')
    if @recipe.update(recipe_params)
      @recipe.save_recipes(tag_list)
      flash[:notice] = "投稿を編集しました"
      redirect_to recipe_path(params[:id])
    else
      render("recipes/edit")
    end
  end

  def show
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user)
    @like = RecipeLike.new
  end

  def search
    @recipes = @q.result.distinct.order("created_at DESC").page(params[:page]).per(9)
    @search_recipes = @q.result.distinct
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

  def set_q
    @q = Recipe.ransack(params[:q])
  end
end