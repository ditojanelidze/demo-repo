# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  skip_before_action :verify_authenticity_token
  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
