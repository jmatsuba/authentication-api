class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    result = AuthenticateUser.call(username: params[:session][:username], password: params[:session][:password])

    if result.success?
      render json: { auth_token: result.token }
    else
      render json: { error: result.message }, status: :unauthorized
    end
  end

  def destroy
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
