require 'rails_helper'

feature 'User create order' do
  scenario 'Successfully' do
    user = create(:user)
    price = Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')
    customer = create(:customer)
    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produto'
    select 'Linux', from: 'Planos'
    select "#{price.name} - #{price.valor}", from: 'Preço'
    click_on 'Efetivar'

    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content("#{price.name} - #{price.valor}")
  end

  scenario 'Failed' do
    user = create(:user)
    Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')
    create(:customer)
    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produto'
    click_on 'Efetivar'

    expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content('Planos não pode ficar em branco')
  end
end
