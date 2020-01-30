require 'rails_helper'

feature 'User create order' do
  scenario 'Successfully' do
    user = create(:user)
    customer = create(:customer)

    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    click_on 'Novo pedido'

    select "#{customer.name} - #{customer.document}"
    select 'Hospedagem Linux', from: 'Produto'
    click_on 'Efetivar'

    expect(page).to have_content(user.id)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content('Hospedagem Linux')
  end

  scenario 'When have no customer or product' do
    user = create(:user)

    login_as user, scope: :user
    visit new_order_path
    click_on 'Efetivar'

    expect(page).to have_content('Customer must exist')
    expect(page).to have_content('Produto não pode ficar em branco')
  end
end
