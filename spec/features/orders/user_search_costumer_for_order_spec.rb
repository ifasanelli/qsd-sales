require 'rails_helper'

feature 'User search costumer for order' do
  scenario 'sucessfully' do
    # Arrange
    user = create(:user)
    customer = create(:customer)
    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: customer.document
    click_on 'Buscar'
    # Assert
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
  end

  scenario 'Customer must be exist' do
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: '123123'
    click_on 'Buscar'

    expect(page).to have_content('Cliente não cadastrado')
  end
end
