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

    private
    def material_params
      params.require(:material).permit(:name, :address)
    end
    
end
