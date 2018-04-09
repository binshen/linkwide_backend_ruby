class Api::V1::ProductsController < Api::V1::BaseController

  def index
    pageSize = params[:pageSize] unless params[:pageSize].blank?
    currentPage = params[:currentPage] unless params[:currentPage].blank?

    pageSize = 10 if pageSize.blank?
    currentPage = 1 if currentPage.blank?
    offset = (currentPage.to_i - 1) * pageSize.to_i

    objModel = Product.select('id as `key`, id, name, type_id, voltage')
    objModel = objModel.where('name LIKE "%' + params[:name] + '%"') unless params[:name].blank?
    list = objModel.limit(pageSize).offset(offset)
    pagination = {total: Product.all.count, pageSize: pageSize, current: currentPage}
    render json: {list: list, pagination: pagination}
  end

  def create
    method = params[:method]
    if method == 'post'
      if params[:name]
        objModel = Product.new(input_params)
        objModel.save
      end
    else
      if params[:id]
        ids = params[:id].to_s.split(',')
        Product.delete(ids)
      end
    end
  end

  def update
    Product.where(id: params[:id]).update(name: params[:name])
  end

  def destroy
    Product.delete(params[:id])
  end


  private

  def input_params
    params.require(:product).permit(:name, :type_id, :voltage)
  end

end