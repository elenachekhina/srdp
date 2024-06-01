# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionPolicy::Controller
  authorize :user, through: :current_user

  rescue_from ActionPolicy::Unauthorized do
    head :forbidden
  end

  def default_authorization_policy_class
    ApplicationPolicy
  end

  private

  def authenticate_user
    return if current_user

    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
