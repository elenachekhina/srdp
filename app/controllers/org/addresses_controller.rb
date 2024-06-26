# frozen_string_literal: true

module Org
  class AddressesController < BaseController
    before_action :set_organization, only: %w[new create]
    before_action :set_address, only: %w[edit update destroy]

    def new
      @address = @organization.build_address
      render partial: 'new', locals: { address: @address, organization: @organization }
    end

    def create
      @address = SearchableCreator.new(Address, address_params.merge(organization: @organization)).call

      if @address.persisted?
        render :create
      else
        render :new
      end
    end

    def edit
      render partial: 'edit', locals: { address: @address }
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
      params.require(:address).permit(:house_number, :street, :district, :city, :state, :postal_code, :country,
                                      :latitude_ovr, :longitude_ovr)
    end
  end
end
