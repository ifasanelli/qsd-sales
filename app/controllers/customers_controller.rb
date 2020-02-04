class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def search
    @customers = Customer.where('document LIKE ?', "%#{params[:q]}%")
    render :index
  end
end
