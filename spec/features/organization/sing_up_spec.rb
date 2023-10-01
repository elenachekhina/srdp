# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor can create an organization', "
  In order to create a profile
  As an owner of organization
  I'd like to be able to register my organization
" do

  scenario 'Not registered organization tries to sign up' do
    Capybara.app_host = "http://localhost:3000/"
    visit organizations_path

    click_on 'Switch to Organization Mode'
    click_on 'Sign up'

    fill_in 'Name', with: 'My organization'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123321'
    fill_in 'Confirm Password', with: '123321'
    click_button 'Create Organization'

    expect(page).to have_content 'Successfully signed up!'
  end

  scenario 'Registered organization tries to sign up' do
    Capybara.app_host = "http://localhost:3000/"
    org = create(:organization)
    visit organizations_path

    click_on 'Switch to Organization Mode'
    click_on 'Sign up'

    fill_in 'Name', with: 'My organization'
    fill_in 'Email', with: org.email
    fill_in 'Password', with: '123321'
    fill_in 'Confirm Password', with: '123321'
    click_button 'Create Organization'

    expect(page).to have_content 'Email has already been taken'
  end
end
