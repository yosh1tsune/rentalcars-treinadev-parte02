require 'rails_helper'

RSpec.describe do
  describe '#confirm' do
    it 'should create a email' do
      client = create(:client, email: 'client@email.com')

      email = ClientMailer.confirm(client.id)

      expect(email.to).to include(client.email)
      expect(email.from).to include 'no-reply@rentalcars.com.br'
      expect(email.subject).to eq 'Cliente registrado com sucesso!'
      expect(email.body).to include "Olá #{client.name}"
      expect(email.body).to include "Seu registro foi concluido com sucesso!"
    end
  end
end