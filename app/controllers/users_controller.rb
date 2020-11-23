class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]
  before_action :set_user, only: [:show]
  
  def mypage
  
  end

  def index
    @users = User.all
  end

  def show
    @nickname = @user.nickname
    @recipes = @user.recipes
    @liked_recipes = @user.liked_recipes
    @materials = @user.materials
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
