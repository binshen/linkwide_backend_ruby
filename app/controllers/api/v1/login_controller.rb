class Api::V1::LoginController < Api::V1::BaseController

  #skip_before_action :authenticate_user!, only: [:create]
  #before_action :authenticate_user, only: [:index, :show]

  def create
    username = params[:username]
    password = params[:password]
    admin = Admin.find_by(username: username)
    if admin && admin.authenticate(password)
      if admin.activated?
        render :json => { status: 'ok', type: params[:type], currentAuthority: 'admin' }
      else
        render :json => { status: 'error', type: params[:type], currentAuthority: 'guest' }
      end
    else
      render :json => { status: 'error', type: params[:type], currentAuthority: 'guest' }
    end

  end

end
