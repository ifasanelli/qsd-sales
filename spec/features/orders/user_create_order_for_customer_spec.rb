require 'rails_helper'

feature 'User create order' do
  scenario 'Successfully' do
    user = create(:user)
    price = Price.new(id: 3, name: '3 Meses', float_value: 30)
    customer = create(:customer)
    login_as user, scope: :user
    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    plans = [Plan.new(1, 'Linux'), Plan.new(2, 'Windows')]
    allow(Plan).to receive(:all).and_return(plans)

    visit root_path
    click_on 'Clientes'
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produto'
    select 'Linux', from: 'Plano'
    select price.expose, from: 'Preço'
    click_on 'Efetivar'

    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content(price.expose)
  end

  scenario 'Failed' do
    user = create(:user)
    Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')
    create(:customer)
    login_as user, scope: :user

    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    plans = [Plan.new(1, 'Linux'), Plan.new(2, 'Windows')]
    allow(Plan).to receive(:all).and_return(plans)

    visit root_path
    click_on 'Clientes'
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produto'
    click_on 'Efetivar'

    expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content('Plano não pode ficar em branco')
  end
end
