class MaterialLikesController < ApplicationController
  before_action :set_material

  def create
    @like = current_user.material_likes.new(material_id: @material.id)
    @like.save
    @likes = MaterialLike.where(material_id: @material.id)
  end

  def destroy
    @like = MaterialLike.find_by(material_id: @material.id, user_id: current_user.id).destroy
    @likes = MaterialLike.where(material_id: @material.id)
  end

  private

  def set_material
    @material = Material.find(params[:material_id])
  end
end
