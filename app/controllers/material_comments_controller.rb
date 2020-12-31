class MaterialCommentsController < ApplicationController
  def create
    @comment = MaterialComment.create(material_comment_params)
    respond_to do |format|
      format.html { redirect_to material_path(params[:material_id]) }
      format.json
    end
  end

  private

  def material_comment_params
    params.require(:material_comment).permit(:text).merge(user_id: current_user.id, material_id: params[:material_id])
  end
end
