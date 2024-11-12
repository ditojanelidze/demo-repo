# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @posts = current_user.posts
    render 'users/profile'
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    result = Users::Create.call(params: create_params)

    if result.success?
      session[:phone_number_confirmation_token] = result.user.phone_number_confirmation_token
      redirect_to phone_verification_user_url(result.user)
    else
      @user = result.user
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(current_user.id)
    result = Users::Update.call(params: update_params, user: @user)
    current_user.reload
    if result.success?
      redirect_to edit_user_url(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def phone_verification
    @user = User.new
  end

  def verify_phone_number
    result = Users::VerifyPhoneNumber.call(params)
    @user = result.user

    if result.success?
      session[:user_id] = @user.id
      session.delete(:phone_number_confirmation_token)
      redirect_to root_path
    elsif @user.persisted?
      render :phone_verification, status: :unprocessable_entity
    else
      render :phone_verification, status: :not_found
    end
  end

  def resend_phone_verification_code
    result = Users::ResendCode.call(phone_number_confirmation_token: session[:phone_number_confirmation_token])
    @user = result.user

    render :phone_verification
  end

  def update_phone_number; end

  def init_update_password
    @user = current_user
  end

  def update_password
    result = Users::UpdatePassword.call(user: current_user, params: update_password_params)
    if result.success?
      redirect_to edit_user_url(current_user)
    else
      @user = result.user
      render :init_update_password, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :phone_number,
                                 :phone_number_iso,
                                 :password)
  end

  def update_params
    params.require(:user).permit(:first_name, :last_name, :locale)
  end

  def update_password_params
    params.require(:user).permit(:password, :new_password, :new_password_confirmation)
  end
end
