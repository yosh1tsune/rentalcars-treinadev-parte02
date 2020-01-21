require 'rails_helper'

feature 'Admin register category' do
  scenario 'successfully' do
    admin = create(:user, role: :admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Nova categoria'
    fill_in 'Nome', with: 'A'
    fill_in 'Diária padrão', with: 80
    fill_in 'Seguro padrão do carro', with: 40
    fill_in 'Seguro padrão contra terceiros', with: 60
    click_on 'Salvar'

    expect(page).to have_content('Categoria salva com sucesso!')
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('Diária: R$ 80,00')
    expect(page).to have_content('Seguro do carro: R$ 40,00')
    expect(page).to have_content('Seguro de terceiros: R$ 60,00')
  end
end