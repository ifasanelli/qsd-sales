class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_costumer_order_product, only: %i[create]
  before_action :find_customer, only: %i[new create]
  before_action :set_order, only: %i[update]
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
    if order_params[:coupon_name].present?
      @order.final_price = calculate_discount(@order)
    end
    if @order.save
      OrderMailer.with(order: @order).order_received.deliver_now
      return redirect_to @order, notice: t('.success')
    end

    load_customers_and_products
    render :new
  end

  def edit
    @order = Order.find(params[:id])
    load_customers_and_products
  end

  def update
    if order_params[:coupon_name].present?
      @order.final_price = calculate_discount(@order)
    end
    if @order.update(order_params)
      OrderMailer.with(order: @order).order_updated.deliver_now
      redirect_to @order
    else
      render :edit
    end
  end

  def cancel
    @order = Order.find(params[:id])
  end

  def finish_cancel
    @order = Order.find(params[:id])
    @order.status = :cancelled
    if @order.update(order_params)
      redirect_to order_path(@order), notice: t('.success')
      OrderMailer.with(order: @order).order_cancelled.deliver_now
    else
      render :cancel
    end
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

  def set_costumer_order_product
    @customer = Customer.find(params[:customer_id])
    @order = @customer.orders.new(order_params)
    @product = Product.find(@order.product_id)
    @order.code = SecureRandom.hex(6)
    @order.user = current_user
  end

  def calculate_discount(order)
    coupon = Coupon.find(order.coupon_name)
    @final_price = coupon.discount
  end

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_order
    @order = Order.find(params[:id])
    @order.coupon_name = order_params[:coupon_name]
  end
end
