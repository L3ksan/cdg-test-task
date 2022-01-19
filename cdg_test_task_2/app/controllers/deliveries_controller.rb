require './lib/delivery_calculator'

class DeliveriesController < ApplicationController
  before_action :set_delivery, only: %i[ show edit update destroy ]

  def index
    @deliveries = Delivery.all
  end

  def show
  end

  def new
    @delivery = Delivery.new
  end

  def edit
  end

  def create
    @delivery = Delivery.new(delivery_params)
    unless @delivery.origin.empty?
      @delivery.distance = DeliveryCalculator.get_distance(delivery_params['origin'], delivery_params['destination'])
    end
    unless @delivery.distance.nil?
      @delivery.price = DeliveryCalculator.calculate_price(delivery_params['weight'].to_f,
                                                           delivery_params['length'].to_f,
                                                           delivery_params['width'].to_f,
                                                           delivery_params['height'].to_f,
                                                           @delivery.distance)
    end
    respond_to do |format|
      if @delivery.save
        format.html { redirect_to delivery_url(@delivery), notice: 'Delivery was successfully created.' }
        format.json { render :show, status: :created, location: @delivery }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @delivery.distance = DeliveryCalculator.get_distance(delivery_params['origin'], delivery_params['destination'])
    @delivery.price = DeliveryCalculator.calculate_price(delivery_params['weight'].to_f,
                                                         delivery_params['length'].to_f,
                                                         delivery_params['width'].to_f,
                                                         delivery_params['height'].to_f,
                                                         @delivery.distance)
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.html { redirect_to delivery_url(@delivery), notice: 'Delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @delivery.destroy

    respond_to do |format|
      format.html { redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

  def delivery_params
    params.require(:delivery).permit(:first_name, :middle_name, :last_name, :phone_number, :email, :weight, :length, 
:width, :height, :origin, :destination, :distance, :price)
  end
end
