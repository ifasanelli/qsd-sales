class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    load_customers_and_products
  end

  def edit
    @order = Order.find(params[:id])
    load_customers_and_products
  end

  def create
    @order = Order.new(order_params)
    @user = current_user
    @order.user_id = 1
    return redirect_to @order if @order.save

    load_customers_and_products
    render :new
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to @order
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :product)
  end

  def load_customers_and_products
    @customers = Customer.all
    @products = Product.all
  end
end
