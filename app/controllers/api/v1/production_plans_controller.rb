class Api::V1::ProductionPlansController < Api::V1::BaseController

  def index
    pageSize = params[:pageSize] unless params[:pageSize].blank?
    currentPage = params[:currentPage] unless params[:currentPage].blank?

    pageSize = 10 if pageSize.blank?
    currentPage = 1 if currentPage.blank?
    offset = (currentPage.to_i - 1) * pageSize.to_i

    objModel = ProductionPlan.select('id as `key`, id, bill_no, customer_id, product_id, amount, kind_id, delivery_date1, delivery_date2, demand, remarks, created')
    objModel = objModel.where('name LIKE "%' + params[:name] + '%"') unless params[:name].blank?
    list = objModel.limit(pageSize).offset(offset)
    pagination = {total: ProductionPlan.all.count, pageSize: pageSize, current: currentPage}
    render json: {list: list, pagination: pagination}
  end

  def create
    method = params[:method]
    if method == 'post'
      if params[:name]
        objModel = ProductionPlan.new(input_params)
        objModel.save
      end
    else
      if params[:id]
        ids = params[:id].to_s.split(',')
        ProductionPlan.delete(ids)
      end
    end
  end

  def update
    ProductionPlan.where(id: params[:id]).update(name: params[:name])
  end

  def destroy
    ProductionPlan.delete(params[:id])
  end


  private

  def input_params
    params.require(:product_plan).permit(:bill_no, :customer_id, :product_id, :amount, :kind_id, :delivery_date1, :delivery_date2, :demand, :remarks, :created)
  end

end