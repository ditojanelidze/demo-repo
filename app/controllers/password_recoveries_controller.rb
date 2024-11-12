# frozen_string_literal: true

class PasswordRecoveriesController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.new
  end

  def create
    result = PasswordRecoveries::Create.call(params: password_recovery_params)
    @user = result.user
    if result.success?
      session[:password_recovery_token] = result.user.password_recovery_token
      redirect_to edit_password_recovery_path
    else
      render :new
    end
  end

  def update
    result = PasswordRecoveries::Update.call(params)
    @user = result.user

    if result.success?
      session.delete(:password_recovery_token)
      redirect_to new_session_path, notice: I18n.t('labels.user_management.password_changed')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def resend_code
    result = PasswordRecoveries::ResendCode.call(password_recovery_token: session[:password_recovery_token])
    @user = result.user

    render :phone_verification
  end

  private

  def password_recovery_params
    params.require(:user).permit(:phone_number, :phone_number_iso)
  end
end
