require 'rails_helper'

feature 'User create order' do
  scenario 'Successfully' do
    user = create(:user)
    costumer = create(:costumer)
    product = Product.new(name: 'Hospedagem Linux')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Pedidos'
    click_on 'Novo pedido'

    select "#{costumer.name} - #{costumer.document}"
    select 'Hospedagem Linux', from: 'Produto'
    click_on 'Contratar'

    expect(page).to have_content(user.id)
    expect(page).to have_content(costumer.name)
    expect(page).to have_content(costumer.document)
    expect(page).to have_content(product.name)
  end
end