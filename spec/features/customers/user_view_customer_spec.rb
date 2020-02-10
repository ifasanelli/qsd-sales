require 'rails_helper'

feature 'User view customer' do
  scenario 'Successfully' do
    # Arrange
    customer = create(:customer)
    other_customer = create(:customer, name: 'George R R Matin',
                                       email: 'george@gmail.com',
                                       document: '440.725.668-01',
                                       phone: '(13) 98216-7677')
    # Act
    visit root_path
    click_on 'Clientes'
    within("tr#customer-#{customer.id}") do
      find("a[href='#{customer_path(customer)}'][data-method='get']").click
    end
    # Assert
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.address)
    expect(page).to have_content(customer.document)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
    expect(page).to have_content(customer.birth_date)
    expect(page).not_to have_content(other_customer.name)
  end
end
