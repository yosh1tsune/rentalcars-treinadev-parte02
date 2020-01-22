class Api::V1::CarsController < Api::V1::ApiController
  def show
    @car = Car.find_by(id: params[:id])

    if @car.blank? 
      render json: @car, status: :not_found
    else
      render json: @car
    end
  end
end