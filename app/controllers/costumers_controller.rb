class CostumersController < ApplicationController
  def index; end

  def show
    @costumer = Costumer.find(params[:id])
  end

  def new
    @costumer = Costumer.new
  end

  def create
    @costumer = Costumer.new(costumer_params)
    @costumer.save
    redirect_to @costumer
  end

  private

  def costumer_params
    params.require(:costumer).permit(:name, :address, :document, :email, :phone,
                                     :birth_date)
  end
end
