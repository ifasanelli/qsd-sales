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
    return render :cancel unless @order.update(order_params)

    redirect_to order_path(@order), notice: t('.success')
  end

  def approve
    @order = Order.find(params[:id])
    return redirect_to @order, notice: t('.success') if @order.approved!
  end

  private

  def order_params
    params.require(:order).permit(:cancellation_reason)
  end
end
