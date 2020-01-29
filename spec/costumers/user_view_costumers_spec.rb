require 'rails_helper'

feature 'User view costumer' do
  scenario 'Successfully' do
    # Arrange
    costumer = create(:costumer)
    other_costumer = create(:costumer, name:'George R R Matin')
    # Act
    visit root_path 
    click_on 'Clientes'
    # Assert
    expect(page).to have_content(costumer.name)
    expect(page).to have_content(costumer.email)
    expect(page).to have_content(other_costumer.name)
  end
end