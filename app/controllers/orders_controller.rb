class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def cancel
    @order = Order.find(params[:id])
  end

  def finish_cancel
    @order = Order.find(params[:id])
    @order.status = :cancelled
    return redirect_to order_path(@order), 
      notice: 'Pedido cancelado com sucesso' if @order.update(order_params)
    
    render :cancel
  end

  private

  def order_params
    params.require(:order).permit(:cancellation_reason)
  end
end