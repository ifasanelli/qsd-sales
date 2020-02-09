require 'rails_helper'

feature 'User edit order with coupon' do
  scenario 'Successfully' do
    # Arrange
    price = Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')
    order = create(:order)
    user = create(:user, email: 'testando@yahoo.com')
    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Alterar'
    fill_in 'Cupom', with: 'NATLOCA01'
    click_on 'Efetivar'
    # Assert
    expect(page).to have_content(user.id)
    expect(page).to have_content(order.customer.identification)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content('1 Mes - R$: 10,00')
    expect(page).to have_content('Preço Total: R$ 7.0')
  end
end
