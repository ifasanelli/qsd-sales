class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def order_received
    @order = params[:order]
    @product = Product.find(@order.product_id)
    @plan = Plan.find(@order.plan_id)
    @price = Price.find(@order.price_id)
    mail(to: @order.customer.email, subject: "Confirmação do pedido ##{@order.code}")
  end

  def order_cancelled
    @order = params[:order]
    mail(to: @order.customer.email, subject: "Cancelamento do pedido ##{@order.code}")
  end

  def order_updated
    @order = params[:order]
    @product = Product.find(@order.product_id)
    @plan = Plan.find(@order.plan_id)
    @price = Price.find(@order.price_id)
    mail(to: @order.customer.email, subject: "Atualização do pedido ##{@order.code}")
  end
end
