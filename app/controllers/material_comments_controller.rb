class MaterialCommentsController < ApplicationController
  def create
    @material = Material.find(params[:material_id])
    @material_comment = @material.material_comments.build(material_comment_params)
    @material_comment.user_id = current_user.id
    if @material_comment.save
      render :index
    end
  end

  def destroy
    @material_comment = MaterialComment.find(params[:id])
    if @material_comment.destroy
      render :index
    end
  end

  private

  def material_comment_params
    params.require(:material_comment).permit(:text, :material_id, :user_id)
  end
end
