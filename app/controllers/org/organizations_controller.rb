# frozen_string_literal: true

module Org
  class OrganizationsController < BaseController
    skip_before_action :authenticate_organization, only: %w[new create]

    def show
      @organization = current_organization
    end

    def new
      @organization = Organization.new
    end

    def create
      @organization = SearchableCreator.new(Organization, organization_params).call

      if @organization.persisted?
        session[:organization_id] = @organization.id
        redirect_to root_path, notice: 'Successfully signed up!'
      else
        render :new
      end
    end

    private

    def organization_params
      params.require(:organization).permit(:name, :email, :password, :password_confirmation, :description)
    end
  end
end
