require 'rails_helper'

feature 'User search costumer for order' do
  scenario 'sucessfully' do
    price = Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')
    user = create(:user, email: 'tst@tst.com')
    customer = create(:customer, user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: '198.725.668-02'
    click_on 'Buscar'
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produtos'
    select 'Linux', from: 'Planos'
    select "#{price.name} - #{price.valor}", from: 'Período'
    click_on 'Efetivar'

    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content("#{price.name} - #{price.valor}")
  end

  scenario "Customer doens't exist" do
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Pesquisar', with: '123123'
    click_on 'Buscar'

    expect(page).to have_content(user.email)
  end
end
