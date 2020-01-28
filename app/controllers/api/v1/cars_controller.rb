class Api::V1::CarsController < Api::V1::ApiController
  def show
    @car = Car.find(params[:id])
    render json: @car
  end

  def index 
    @cars = Car.all

    if @cars.blank?
      render json: 'Object not find', status: :not_found
    else
      render json: @cars
    end
  end

  def create
    car = Car.new(car_km: params[:car_km], color: params[:color],
                      license_plate: params[:license_plate],
                      subsidiary_id: params[:subsidiary_id], 
                      car_model_id: params[:car_model_id])

    if car.valid?
      car.save!
      render json: car.id, status: :created
    else
      render json: 'Object not created', status: 412
    end
  end

  def update
    car = Car.find(params[:id])
    car.assign_attributes(car_params)

    if car.valid?
      car.update!(car_params)
      render json: car, status: :ok
    else
      render json: 'Object not updated', status: 412
    end
  end

  def destroy
    @car = Car.find(params[:id])

    @car.destroy

    render json: 'Objeto deletado com sucesso!', status: :ok
  end

  private

  def car_params
    {car_km: params[:car_km], color: params[:color],
      license_plate: params[:license_plate],
      subsidiary_id: params[:subsidiary_id], 
      car_model_id: params[:car_model_id]}
  end
end