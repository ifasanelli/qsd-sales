require 'rails_helper'

feature 'User view customer' do
  scenario 'Successfully' do
    # Arrange
    customer = create(:customer)
    other_customer = create(:customer, name: 'George R R Matin')
    # Act
    visit root_path
    click_on 'Clientes'
    # Assert
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(other_customer.name)
  end
end
