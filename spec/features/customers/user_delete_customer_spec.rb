require 'rails_helper'

feature 'User delete customer' do
  scenario 'Successfully' do
    # Arrange
    user = create(:user, email: 'tst@tst.com')
    customer = create(:customer, user: user)
    other_customer = create(:customer, name: 'Edgar A Poe',
                                       email: 'eap@gmail.com',
                                       document: '455.725.668-01',
                                       phone: '(12) 98216-2277',
                                       user: user)
    login_as(user, scope: :user)
    visit root_path
    # Act
    click_on 'Clientes'
    click_on customer.name.to_s
    click_on 'Apagar'
    # Assert
    expect(current_path).to eq(customers_path)
    expect(page).not_to have_content(customer.name)
    expect(page).to have_content(other_customer.name)
  end
end
