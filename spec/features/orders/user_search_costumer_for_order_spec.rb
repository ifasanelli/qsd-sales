require 'rails_helper'

feature 'User search costumer for order' do
  scenario 'sucessfully' do
    user = create(:user)
    customer = create(:customer)

    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: '36971828876'
    click_on 'Buscar'
    click_on 'Novo Pedido'
    select 'Hospedagem Linux', from: 'Produto'
    click_on 'Efetivar'

   
    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem Linux')
  end

  scenario 'Customer must be exist' do
    user = create(:user)

    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: '123123'
    click_on 'Buscar'

    expect(page).to have_content('Cliente não cadastrado')
  end
end
