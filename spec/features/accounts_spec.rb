require 'rails_helper'

feature 'Accounts' do
  scenario 'visiting the accounts page shows my accounts' do
    visit accounts_path
    expect(page).to have_content 'My accounts'
  end
end
