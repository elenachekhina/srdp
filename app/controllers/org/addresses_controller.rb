module Org
  class AddressesController < BaseController
    before_action :set_organization, only: %w[new create]
    before_action :set_address, only: %w[edit update destroy]

    def new
      @address = @organization.build_address
      render partial: 'form', locals: { address: @address, organization: @organization }
    end

    def create
      @address = @organization.build_address(address_params)

      if @address.save
        render :create
      else
        render :new
      end
    end

    def edit
      render partial: 'form_edit', locals: { address: @address }
    end

    def update
      if @address.update(address_params)
        render :update
      else
        render :edit
      end
    end

    def destroy
      @organization = @address.organization
      @address.destroy
      @organization.reload
    end

    private

    def set_address
      @address = Address.find(params[:id])
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def address_params
      params.require(:address).permit(:street, :city, :state, :postal_code, :country, :latitude, :longitude)
    end
  end
end
