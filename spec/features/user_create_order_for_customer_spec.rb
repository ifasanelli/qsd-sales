require 'rails_helper'

feature 'User create order' do
  scenario 'Successfully' do
    user = create(:user)
    customer = create(:customer)
    product = Product.new(name: 'Hospedagem Linux')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    click_on 'Novo pedido'

    select "#{customer.name} - #{customer.document}"
    select 'Hospedagem Linux', from: 'Produto'
    click_on 'Contratar'

    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content(product.name)
  end
end