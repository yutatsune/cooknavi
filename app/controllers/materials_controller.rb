class MaterialsController < ApplicationController
  before_action :set_material, only: %i[edit show]
  before_action :move_to_index, except: %i[index show]

  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
    @material.material_images.new
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

  def edit; end

  def update
    @material = Material.find(params[:id])
    length = @material.material_images.length
    i = 0
    while i < length
      if material_params[:material_images_attributes][i.to_s]["_destroy"] == "0"
        @material.update(material_params)
        flash[:notice] = "投稿を編集しました"
        redirect_to("/materials")
        return
      else
        i += 1
      end
    end
    @material.update(material_params) if material_params[:images_attributes][i.to_s]
    render("materials/edit")
    nil
  end

  def show
    @materials = Material.all
    @like = MaterialLike.new
    gon.material_latitude = @material.latitude
    gon.material_longitude = @material.longitude
  end

  def search
    @materials = Material.search(params[:keyword])
  end

  private

  def material_params
    params.require(:material).permit(:name, :postcode, :prefecture_code, :address_city, :address_street, :address_building, material_images_attributes: %i[src _destroy id]).merge(user_id: current_user.id)
  end

  def set_material
    @material = Material.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end