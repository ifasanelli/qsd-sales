require 'rails_helper'

feature 'User delete customer' do
  scenario 'Successfully' do
    # Arrange
    customer = create(:customer)
    other_customer = create(:customer, name: 'George R R Matin')
    # Act
    visit root_path
    click_on 'Clientes'
    click_on customer.name.to_s
    click_on 'Apagar'
    # Assert
    expect(current_path).to eq(customers_path)
    expect(page).not_to have_content(customer.name)
    expect(page).to have_content(other_customer.name)
  end
end
