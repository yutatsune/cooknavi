class MaterialsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
  end

  def create
    Material.create(material_params)
  end

  def destroy
    material = Material.find(params[:id])
    material.destroy
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    material = Material.find(params[:id])
    material.update(material_params)
  end

  def show
    @material = Material.find(params[:id])
    @materials = Material.all
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
