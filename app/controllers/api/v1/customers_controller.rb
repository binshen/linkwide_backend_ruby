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
    puts "=======================2"
    puts params
    render json: { status: 1 }
  end

end
