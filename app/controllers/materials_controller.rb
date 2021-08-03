class MaterialsController < ApplicationController
  before_action :set_material, only: %i[edit show]
  before_action :move_to_index, except: %i[index show search]
  before_action :set_q, only: [:index, :search]

  def index
    @materials = Material.includes(:user).order("created_at DESC").page(params[:page]).per(9)
    @all_ranks = Material.create_material_ranks
  end

  def new
    @material = Material.new
    @material.material_images.new
  end

  def create
    @material = Material.new(material_params)
    tag_list = params[:material][:tag_name].split(',')
    if @material.save
      @material.save_materials(tag_list)
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
    @tag_list = @material.mtags.pluck(:tag_name).join(",")
  end

  def update
    @material = Material.find(params[:id])
    @tag_list = @material.mtags.pluck(:tag_name).join(",")
    tag_list = params[:material][:tag_name].split(',')
    if @material.update(material_params)
      @material.save_materials(tag_list)
      flash[:notice] = "投稿を編集しました"
      redirect_to material_path(params[:id])
    else
      render("materials/edit")
    end
  end

  def show
    @comment = MaterialComment.new
    @comments = @material.material_comments.includes(:user)
    @like = MaterialLike.new
    gon.material_latitude = @material.latitude
    gon.material_longitude = @material.longitude
  end

  def search
    @materials = @q.result.distinct.page(params[:page]).per(9)
  end

  private

  def material_params
    params.require(:material).permit(:name, :shop, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :explanation, material_images_attributes: %i[src _destroy id]).merge(user_id: current_user.id)
  end

  def set_material
    @material = Material.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_q
    @q = Material.ransack(params[:q])
  end
end
