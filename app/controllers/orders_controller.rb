class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def finish_cancel
    @order = Order.find(params[:id])
    redirect_to order_path(@order), notice: 'Pedido cancelado com sucesso' if @order.cancelled!
  end

  def cancel
    @order = Order.find(params[:id])
  end
end