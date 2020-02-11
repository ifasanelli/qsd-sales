class CustomerMailer < ApplicationMailer
  default from: 'naoresponda@minilocaweb.com'

  def new_customer
    @customer = params[:customer]
    mail(to: @customer.email, subject: "Bem-vindo #{@customer.name}")
  end

  def customer_updated
    @customer = params[:customer]
    mail(to: @customer.email, subject: "Atualização de dados")
  end

  def customer_deleted
    @customer = params[:customer]
    mail(to: @customer.email, subject: "Até breve #{@customer.name}")
  end
end
