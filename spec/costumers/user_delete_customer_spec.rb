require 'rails_helper'

feature 'User delete customer' do
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
    within("tr#customer-#{customer.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Apagar'
    # Assert
    expect(current_path).to eq(customers_path)
    expect(page).not_to have_content(customer.name)
    expect(page).to have_content(other_customer.name)
  end

  scenario 'by index' do
    # Arrange
    customer = create(:customer)
    other_customer = create(:customer, name: 'Edgar A Poe',
                                       email: 'edgar@gmail.com',
                                       document: '455.725.668-01',
                                       phone: '(12) 98216-2277')
    # Act
    visit root_path
    click_on 'Clientes'
    within("tr#customer-#{customer.id}") do
      find('.ls-ico-remove').click
    end
    # Assert
    expect(current_path).to eq(customers_path)
    expect(page).not_to have_content(customer.name)
    expect(page).to have_content(other_customer.name)
  end
end
