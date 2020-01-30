require 'rails_helper'

feature 'User edit customer' do
  scenario 'successfully' do
    # Arrange
    customer = create(:customer)
    # Act
    visit root_path
    click_on 'Clientes'
    click_on customer.name.to_s
    click_on 'Editar'
    fill_in 'Nome', with: 'George R R Martin'
    click_on 'Salvar'
    # Assert
    expect(page).not_to have_content(customer.name)
    expect(page).to have_content('George R R Martin')
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end
end