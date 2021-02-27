class MaterialsController < ApplicationController
  before_action :move_to_index, except: %i[index show search]

  def index
    @materials = Material.includes(:user).order("created_at DESC")
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
    material = current_user.materials.find(params[:id])
    material.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/materials")
  end

  def edit
    @material = current_user.materials.find(params[:id])
  end

  def update
    @material = current_user.materials.find(params[:id])
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
    @material.update(material_params) if material_params[:material_images_attributes][i.to_s]
    render("materials/edit")
    nil
  end

  def show
    @material = Material.find(params[:id])
    @materials = Material.all
    @comment = MaterialComment.new
    @comments = @material.material_comments.includes(:user)
    @like = MaterialLike.new
    gon.material_latitude = @material.latitude
    gon.material_longitude = @material.longitude
  end

  def search
    @materials = Material.search(params[:keyword])
  end

  private

  def material_params
    params.require(:material).permit(:name, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :explanation, material_images_attributes: %i[src _destroy id]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
