require 'rails_helper'

feature 'User view customer' do
  scenario 'Successfully' do
    # Arrange
    customer = create(:customer)
    other_customer = create(:customer, name: 'Edgar A Poe',
                                       email: 'edgar@gmail.com',
                                       document: '455.725.668-01',
                                       phone: '(12) 98216-2277')
    # Act
    visit root_path
    click_on 'Clientes'
    # Assert
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(other_customer.name)
  end
end
