class Api::V1::LoginController < Api::V1::BaseController

  #skip_before_action :authenticate_user!, only: [:create]
  #before_action :authenticate_user, only: [:index, :show]

  def create
    username = params[:username]
    password = params[:password]
    admin = Admin.find_by(username: username)
    if admin
      if admin.authenticate(password) && admin.activated?
        render json: { status: 'ok', type: params[:type], currentAuthority: 'admin' }
      else
        render json: { status: 'error', type: params[:type], currentAuthority: 'guest', content: "账户或密码错误" }
      end
    else
      render json: { status: 'error', type: params[:type], currentAuthority: 'guest', content: "该账户不存在" }
    end

  end

end
