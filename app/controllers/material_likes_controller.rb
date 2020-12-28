class MaterialLikesController < ApplicationController
  def create
    @like = current_user.material_likes.create(material_id: params[:material_id])
    flash[:notice] = '投稿に｢いいね！｣しました'
    redirect_to material_path(params[:material_id])
  end

  def destroy
    @like = MaterialLike.find_by(material_id: params[:material_id], user_id: current_user.id)
    @like.destroy
    flash[:notice] = '｢いいね！｣を解除しました'
    redirect_to material_path(params[:material_id])
  end
end
