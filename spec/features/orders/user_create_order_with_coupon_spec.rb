require 'rails_helper'

feature 'User create order with coupon' do
  scenario 'Successfully' do
    # Arrange
    prices = [Price.new(1, 1, 1, 'Mensal')]
    allow(Price).to receive(:all).and_return(prices)
    customer = create(:customer)
    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    plans = [Plan.new(1, 'Linux'), Plan.new(2, 'Windows')]
    allow(Plan).to receive(:all).and_return(plans)
    coupon = Coupon.new(name: 'NATLOCA01', discount: 21)
    user = create(:user)

    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produto'
    select 'Linux', from: 'Plano'
    select prices[0].expose, from: 'Preço'
    fill_in 'Cupom', with: coupon.name
    click_on 'Efetivar'
    
    # Assert
    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content(prices[0].expose)
    expect(page).to have_content('Preço Total: R$ 21.0')
  end
end
