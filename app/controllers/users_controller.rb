class UsersController < ApplicationController
  def edit

  end

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @recipes = user.recipes
  end
end
