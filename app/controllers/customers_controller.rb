class CustomersController < ApplicationController
  before_action :find_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.all
  end

  def search
    @customers = Customer.where('document LIKE ?', "%#{params[:q]}%")
    render :index
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :document, :email,
                                     :phone, :birth_date)
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end
end
