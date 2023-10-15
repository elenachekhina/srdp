# frozen_string_literal: true

module Org
  class SessionsController < BaseController
    skip_before_action :authenticate_organization, only: %w[new create]
    def new
    end

    def create
      organization = Organization.find_by(email: session_params[:email])

      if organization&.authenticate(session_params[:password])
        session[:organization_id] = organization.id
        redirect_to org_organization_path(organization), notice: 'Successfully signed in!'

      else
        render :new
      end
    end

    def destroy
      session[:organization_id] = nil
      redirect_to root_path
    end

    private

    def session_params
      params.require(:session).permit(:email, :password)
    end
  end
end
