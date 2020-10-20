class MaterialsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    if @material.save
      flash[:notice] = "新規投稿しました"
      redirect_to("/materials")
    else
      render("materials/new")
    end
  end

  def destroy
    material = Material.find(params[:id])
    material.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/materials")
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if @material.update(material_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to("/materials")
    else
      render("materials/edit")
    end
  end

  def show
    @material = Material.find(params[:id])
    @materials = Material.all
    gon.material_latitude = @material.latitude
    gon.material_longitude = @material.longitude
  end

  def search
    @materials = Material.search(params[:keyword])
  end

  private
  def material_params
    params.require(:material).permit(:name, :postcode, :prefecture_code, :address_city, :address_street, :address_building).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
