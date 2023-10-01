# frozen_string_literal: true

require 'rails_helper'

feature 'Owner can login as an organization', "
  In order to manage organization accounr
  As an owner of organization
  I'd like to be able to sign in
" do

  scenario 'Not registered organization tries to sign in' do
    Capybara.app_host = "http://localhost:3000/"
    visit organizations_path

    click_on 'Switch to Organization Mode'
    click_link 'Sign in'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123321'

    click_button 'Sign in'

    expect(page).not_to have_content 'Successfully signed in!'
  end

  scenario 'Registered organization tries to sign up' do
    Capybara.app_host = "http://localhost:3000/"
    org = create(:organization)
    visit organizations_path

    click_on 'Switch to Organization Mode'
    click_link 'Sign in'

    fill_in 'Email', with: org.email
    fill_in 'Password', with: org.password

    click_button 'Sign in'

    expect(page).to have_content 'Successfully signed in!'
  end
end
