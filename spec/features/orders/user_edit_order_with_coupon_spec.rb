require 'rails_helper'

feature 'User edit order with coupon' do
  scenario 'Successfully' do
    # Arrange
    order = create(:order, price_id: 3)
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
    expect(page).to have_content('3 Meses - R$ 30,00')
    expect(page).to have_content('Preço Total: R$ 21.0')
  end
end
