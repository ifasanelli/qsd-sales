require 'rails_helper'

feature 'User create order with coupon' do
  scenario 'Successfully' do
    # Arrange
    price = Price.new(id: 3, name: '3 Meses', valor: 'R$: 30,00')
    customer = create(:customer)
    coupon = Coupon.new(name: 'NATLOCA01', discount: 0.3)
    user = create(:user)
    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on customer.name
    click_on 'Novo Pedido'
    select 'Hospedagem', from: 'Produto'
    select 'Linux', from: 'Planos'
    select "#{price.name} - #{price.valor}", from: 'Período'
    fill_in 'Coupon',	with: 'NATLOCA01'
    click_on 'Efetivar'
    # Assert
    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content("#{price.name} - #{price.valor}")
    expect(page).to have_content("Preço Total: #{pricet.float_value * (1 - coupon.discount)}")
  end
end
