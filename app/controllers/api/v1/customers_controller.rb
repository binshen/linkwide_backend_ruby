class Api::V1::CustomersController < Api::V1::BaseController

  def index
    customer = Customer.select('id as `key`, id, name, activated')
    if params[:name]
      customer = customer.where('name LIKE "%' + params[:name] + '%"')
    end
    if params[:activated]
      customer = customer.where(activated: params[:activated])
    end
    list = customer.limit(10).offset(0)
    pagination = {total: Customer.all.count, pageSize: 10, current: 1}
    render json: {list: list, pagination: pagination}
  end

  def create
    method = params[:method]
    if method == 'post'
      if params[:name]
        @customer = Customer.new(customer_params)
        @customer.save
        render json: { status: 1 }
      else
        render json: { status: 0 }
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

  # def destroy
  #   puts '+++++++++++++4'
  #   puts params
  # end
  #
  # private
  # def customer_params
  #   params.require(:customer).permit(:name)
  # end

end
