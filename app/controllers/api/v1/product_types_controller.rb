class Api::V1::ProductTypesController < Api::V1::BaseController

  def index
    render json: ProductType.all
  end

  def create

  end

  def update

  end

  def destroy

  end

end
