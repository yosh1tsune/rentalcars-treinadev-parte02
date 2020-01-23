require 'rails_helper'

feature 'Admin edit category' do
  scenario 'successfully' do
    user = create(:user, role: :admin)

    create(:category, name: 'A')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'A'
    click_on 'Editar'
    fill_in 'Nome', with: 'B'
    fill_in 'Diária padrão', with: '60'
    fill_in 'Seguro padrão do carro', with: '55'
    fill_in 'Seguro padrão contra terceiros', with: '37'
    click_on 'Salvar'

    expect(page).to have_content('Categoria atualizada com sucesso!')
    expect(page).to have_content('Categoria: B')
    expect(page).to have_content('Diária: R$ 60,00')
    expect(page).to have_content('Seguro do carro: R$ 55,00')
    expect(page).to have_content('Seguro de terceiros: R$ 37,00')
  end
end