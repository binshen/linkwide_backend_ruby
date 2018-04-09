class Api::V1::ComponentTypesController < Api::V1::BaseController

  def index
    pageSize = params[:pageSize] unless params[:pageSize].blank?
    currentPage = params[:currentPage] unless params[:currentPage].blank?

    pageSize = 10 if pageSize.blank?
    currentPage = 1 if currentPage.blank?
    offset = (currentPage.to_i - 1) * pageSize.to_i

    objModel = ComponentType.select('id as `key`, id, name')
    objModel = objModel.where('name LIKE "%' + params[:name] + '%"') unless params[:name].blank?
    list = objModel.limit(currentPage).offset(offset)
    pagination = {total: ComponentType.all.count, pageSize: 10, current: 1}
    render json: {list: list, pagination: pagination}
  end

  def create
    method = params[:method]
    if method == 'post'
      if params[:name]
        objModel = ComponentType.new(input_params)
        objModel.save
      end
    else
      if params[:id]
        ids = params[:id].to_s.split(',')
        ComponentType.delete(ids)
      end
    end
  end

  def update
    ComponentType.where(id: params[:id]).update(name: params[:name])
  end

  def destroy
    ComponentType.delete(params[:id])
  end


  private

  def input_params
    params.require(:component_type).permit(:name)
  end

end
