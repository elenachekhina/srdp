# frozen_string_literal: true

module Org
  class ContactsController < BaseController
    before_action :set_organization, only: %w[new create]
    before_action :set_contact, only: %w[update edit destroy]

    def new
      @contact = @organization.contacts.new
      render partial: 'org/contacts/form', locals: { organization: @organization, contact: @contact }
    end

    def create
      @contact = @organization.contacts.new(contact_params)

      if @contact.save
        render :create
      else
        render :new
      end
    end

    def show; end

    def edit
      render partial: 'org/contacts/form_edit', locals: { contact: @contact }
    end

    def update
      if @contact.update(contact_params)
        render :update
      else
        render :edit
      end
    end

    def destroy
      @organization = @contact.organization
      @contact.destroy
    end

    private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def contact_params
      params.require(obj_class(@contact)).permit(:type, :value)
    end

    def obj_class(contact)
      return :contact if contact.nil?

      contact.class.to_s.underscore.to_sym
    end
  end
end
