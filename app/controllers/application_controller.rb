# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    nil
  end
  helper_method :current_user
end
