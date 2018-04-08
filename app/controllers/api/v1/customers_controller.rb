class Api::V1::CustomersController < Api::V1::BaseController

  def index
    customer = Customer.select('id as `key`, id, name, activated')
    customer = customer.where('name LIKE "%' + params[:name] + '%"') unless params[:name].blank?
    customer = customer.where(activated: params[:activated]) unless params[:activated].blank?
    list = customer.limit(10).offset(0)
    pagination = {total: Customer.all.count, pageSize: 10, current: 1}
    render json: {list: list, pagination: pagination}
  end

  def create
    method = params[:method]
    if method == 'post'
      if params[:name]
        customer = Customer.new(customer_params)
        customer.save
      end
    else
      if params[:id]
        customer_ids = params[:id].to_s.split(',')
        if method == 'remove'
          Customer.delete(customer_ids)
        elsif method == 'activate'
          Customer.where(id: customer_ids).update(activated: 1)
        elsif method == 'deactivate'
          Customer.where(id: customer_ids).update(activated: 0)
        end
      end
    end
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer
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

  def customer_params
    params.require(:customer).permit(:name, :activated)
  end

end
