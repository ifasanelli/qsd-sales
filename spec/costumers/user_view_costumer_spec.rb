require 'rails_helper'

feature 'User view costumer' do
  scenario 'Successfully' do
    # Arrange
    costumer = create(:costumer)
    other_costumer = create(:costumer, name:'George R R Matin')
    # Act
    visit root_path 
    click_on 'Clientes'
    click_on "#{costumer.name}"
    # Assert
    expect(page).to have_content(costumer.name)
    expect(page).to have_content(costumer.address)
    expect(page).to have_content(costumer.document)
    expect(page).to have_content(costumer.email)
    expect(page).to have_content(costumer.phone)
    expect(page).to have_content(costumer.birth_date)
    expect(page).not_to have_content(other_costumer.name)
  end
end