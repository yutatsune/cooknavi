class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]
  before_action :set_user, only: [:show]

  def mypage; end

  def index
    @users = User.all
  end

  def show
    @nickname = @user.nickname
    @followings = @user.followings
    @followed = @user.reverse_of_relationships
    @recipes = @user.recipes.order("created_at DESC")
    @liked_recipes = @user.liked_recipes.order("created_at DESC")
    @materials = @user.materials
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
