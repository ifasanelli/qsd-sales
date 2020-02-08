class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @product = Product.find(@order.product_id)
    @plan = Plan.find(@order.plan_id)
    @price = Price.find(@order.price_id)
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @order = Order.new
    load_customers_and_products
  end

  def edit
    @order = Order.find(params[:id])
    load_customers_and_products
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @order = @customer.orders.new(order_params)
    @product = Product.find(@order.product_id)
    @order.user = current_user
    return redirect_to @order if @order.save

    load_customers_and_products
    render :new
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to @order
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

  private

  def order_params
    params.require(:order).permit(:product_id, :plan_id,
                                  :price_id, :cancellation_reason)
  end

  def load_customers_and_products
    @customers = Customer.all
    @products = Product.all
    @plans = Plan.all
    @prices = Price.all
  end
end
