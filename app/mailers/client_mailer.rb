class ClientMailer < ApplicationMailer

  default from: 'no-reply@rentalcars.com.br'

  def confirm(client_id)
    @client = Client.find(client_id)
    
    mail(to: @client.email,
         subject: 'Cliente registrado com sucesso!')
  end
end