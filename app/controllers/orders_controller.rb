class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @customers = Customer.all
    @products = Product.all
  end

  def edit
    @order = Order.find(params[:id])
    @customers = Customer.all
    @products = Product.all  
  end

  def create
    @order = Order.new(order_params)
    @user = current_user
    @order.user_id = 1 
    @order.save!
    
    redirect_to orders_path
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
end