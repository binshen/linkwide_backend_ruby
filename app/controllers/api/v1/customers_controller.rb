class Api::V1::CustomersController < Api::V1::BaseController

  def index
    render json: Customer.all.to_json
  end

  def create
    puts params
    render json: { status: 1 }
  end

end
