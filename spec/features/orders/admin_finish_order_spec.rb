require 'rails_helper'

feature 'User finish order' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer)

    visit order_path(order)
    # click_on 'Pedidos'
    # click_on "#{order.code}"
    click_on 'Aprovar'

    expect(page).to have_content('Pedido aprovado com sucesso')
    expect(page).to have_content(order.code.to_s)
    expect(page).to have_content('Status: Aprovado')
  end

  scenario 'and coupon must be valid' do
    # code, :valid, :final_price
    coupon = Coupon.new(code: 'NATAL001', valid: false, discount: 31.50)
    coupons = Coupon.all << coupon
    product = Product.new(code: 'HOSP2020', category: 'Linux', price: 200.70)
    user = create(:user)
    customer = create(:customer)
    order = create(:order, user: user, customer: customer, coupon: coupons.length-1)

    visit order_path(order)
    # click_on 'Pedidos'
    # click_on "#{order.code}"
    click_on 'Aprovar'

    expect(page).to have_content('Cupom inválido')
    expect(page).to have_content(order.code.to_s)
    expect(page).to have_content('Status: Aberto')

  end
end
