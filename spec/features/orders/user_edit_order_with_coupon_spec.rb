require 'rails_helper'

feature 'User edit order with coupon' do
  scenario 'Successfully' do
    # Arrange
    order = create(:order, price_id: 3)
    user = create(:user, email: 'testando@yahoo.com')
    products = [Product.new(1, 'Hospedagem'), Product.new(2, 'CLOUD')]
    allow(Product).to receive(:all).and_return(products)
    plans = [Plan.new(1, 'Linux'), Plan.new(2, 'Windows')]
    allow(Plan).to receive(:all).and_return(plans)
    prices = [Price.new(3, 1, 1, 'Mensal')]
    allow(Price).to receive(:all).and_return(prices)

    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    within("tr#order-#{order.id}") do
      find("a[href='#{order_path(order)}'][data-method='get']").click
    end
    click_on 'Editar'
    fill_in 'Cupom', with: 'NATLOCA01'
    click_on 'Efetivar'
    # Assert
    expect(page).to have_content(user.id)
    expect(page).to have_content(order.customer.identification)
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Linux')
    expect(page).to have_content("#{prices[0].expose}")
    expect(page).to have_content('Preço Total: R$ 21.0')
  end
end
