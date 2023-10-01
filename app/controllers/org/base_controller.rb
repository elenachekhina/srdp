# frozen_string_literal: true

module Org
  class BaseController < ApplicationController
    layout 'org_application'
    before_action :authenticate_organization

    helper_method :current_organization, :root_path
    def current_organization
      @current_organization ||= Organization.find_by(id: session[:organization_id]) if session[:organization_id]
    end

    def root_path
      org_root_path
    end

    def authenticate_organization
      return if current_organization

      redirect_to org_login_path
    end
  end
end