class CostumersController < ApplicationController
  def index
    @customers = Costumer.all
  end

  def show
    @customer = Costumer.find(params[:id])
  end

  def new
    @customer = Costumer.new
  end

  def create
    @customer = Costumer.new(customer_params)
    @customer.save
    redirect_to @customer
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :document, :email, :phone,
                                     :birth_date)
  end
end
