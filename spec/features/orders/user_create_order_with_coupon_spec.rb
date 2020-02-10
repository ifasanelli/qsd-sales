require 'rails_helper'

feature 'User create order with coupon' do
  scenario 'Successfully' do
    # Arrange
    user = create(:user)
    price = Price.new(id: 3, name: '3 Meses', float_value: 30)
    customer = create(:customer, user: user)
    coupon = Coupon.new(name: 'NATLOCA01', discount: 21)
    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produto'
    select 'Linux', from: 'Planos'
    select price.expose, from: 'Preço'
    fill_in 'Cupom', with: coupon.name
    click_on 'Efetivar'
    # Assert
    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content(price.expose)
    expect(page).to have_content('Preço Total: R$ 21.0')
  end
end
