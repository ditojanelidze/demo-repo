# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    result = Users::Authenticate.call(params: user_params)

    if result.success?
      session[:user_id] = result.user.id
      redirect_to root_path
    else
      flash.now[:alert] = I18n.t('custom_errors.login_failure')
      @user = User.new(user_params)
      render :new, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:phone_number_iso, :phone_number, :password)
  end
end
