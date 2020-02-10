class OrdersController < ApplicationController
  before_action :find_customer, only: %i[new create]
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
    @order = Order.new
    load_customers_and_products
  end

  def create
    @order = @customer.orders.new(order_params)
    @order.user = current_user
    if order_params[:coupon_name].present?
      @order.final_price = calculate_discount(@order)
    end
    return redirect_to @order, notice: t('.success') if @order.save

    load_customers_and_products
    render :new
  end

  def edit
    @order = Order.find(params[:id])
    load_customers_and_products
  end

  def update
    @order = Order.find(params[:id])
    @order.coupon_name = order_params[:coupon_name]
    if order_params[:coupon_name].present?
      @order.final_price = calculate_discount(@order)
    end
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
                                  :price_id, :cancellation_reason,
                                  :coupon_name)
  end

  def load_customers_and_products
    @customers = Customer.all
    @products = Product.all
    @plans = Plan.all
    @prices = Price.all
  end

  def calculate_discount(order)
    coupon = Coupon.find(order.coupon_name)
    @final_price = coupon.discount
  end

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end
end
