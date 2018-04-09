class Api::V1::CustomersController < Api::V1::BaseController

  def index
    objModel = Customer.select('id as `key`, id, name, activated')
    objModel = objModel.where('name LIKE "%' + params[:name] + '%"') unless params[:name].blank?
    objModel = objModel.where(activated: params[:activated]) unless params[:activated].blank?
    list = objModel.limit(10).offset(0)
    pagination = {total: Customer.all.count, pageSize: 10, current: 1}
    render json: {list: list, pagination: pagination}
  end

  def create
    method = params[:method]
    if method == 'post'
      if params[:name]
        objModel = Customer.new(input_params)
        objModel.save
      end
    else
      if params[:id]
        ids = params[:id].to_s.split(',')
        if method == 'remove'
          Customer.delete(ids)
        elsif method == 'activate'
          Customer.where(id: ids).update(activated: 1)
        elsif method == 'deactivate'
          Customer.where(id: ids).update(activated: 0)
        end
      end
    end
  end

  def update
    method = params[:method]
    if method == 'update_status'
      Customer.where(id: params[:id]).update(activated: params[:activated])
    elsif method == 'update_name'
      Customer.where(id: params[:id]).update(name: params[:name])
    end
  end

  def destroy
    Customer.delete(params[:id])
  end


  private

  def input_params
    params.require(:customer).permit(:name, :activated)
  end

end
