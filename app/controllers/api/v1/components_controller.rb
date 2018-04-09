class Api::V1::ComponentsController < Api::V1::BaseController

  def index
    pageSize = params[:pageSize] unless params[:pageSize].blank?
    currentPage = params[:currentPage] unless params[:currentPage].blank?

    pageSize = 10 if pageSize.blank?
    currentPage = 1 if currentPage.blank?
    offset = (currentPage.to_i - 1) * pageSize.to_i

    objModel = Component.select('id as `key`, id, name, type_id, unit')
    objModel = objModel.where('name LIKE "%' + params[:name] + '%"') unless params[:name].blank?
    list = objModel.limit(pageSize).offset(offset)
    pagination = {total: Component.all.count, pageSize: pageSize, current: currentPage}
    render json: {list: list, pagination: pagination}
  end

  def create
    method = params[:method]
    if method == 'post'
      if params[:name]
        objModel = Component.new(input_params)
        objModel.save
      end
    else
      if params[:id]
        ids = params[:id].to_s.split(',')
        Component.delete(ids)
      end
    end
  end

  def update
    Component.where(id: params[:id]).update(name: params[:name])
  end

  def destroy
    Component.delete(params[:id])
  end


  private

  def input_params
    params.require(:component).permit(:name, :type_id, :unit)
  end

end