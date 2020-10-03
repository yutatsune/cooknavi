class MaterialsController < ApplicationController

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

    private
    def material_params
      params.require(:material).permit(:name, :address)
    end

end
