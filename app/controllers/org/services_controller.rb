module Org
  class ServicesController < BaseController
    before_action :set_organization, only: [:index, :new, :create]
    before_action :set_service, only: [:show, :edit, :update, :destroy]

    def index
      @services = @organization.services
    end

    def show

    end

    def new
      @service = @organization.services.build
      render partial: 'new', locals: { service: @service, organization: @organization }
    end

    def create
      @service = @organization.services.build(service_params)

      if @service.save
        render :create
      else
        render :new
      end
    end

    def edit
      render partial: 'edit', locals: { service: @service }
    end

    def update
      if @service.update(service_params)
        render :update
      else
        render :edit
      end
    end

    def destroy
      @organization = @service.organization
      @service.destroy
      render :destroy
    end

    private

    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name, :description, :duration, :pricing, :currency)
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end
  end
end

