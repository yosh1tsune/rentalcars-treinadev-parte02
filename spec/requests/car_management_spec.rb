require 'rails_helper'

describe 'Car Management' do
  context 'show' do
    it 'successfully' do
      car = create(:car)

      get api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:car_model_id]).to eq(car.car_model_id)
      expect(json[:car_km]).to eq(car.car_km)
      expect(json[:license_plate]).to eq(car.license_plate)
      expect(json[:color]).to eq(car.color)
      expect(json[:subsidiary_id]).to eq(car.subsidiary_id)
    end

    it 'not found' do
      get api_v1_car_path(id: 999)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'index' do
    it 'successfully' do
      cars = create_list(:car, 5)

      get api_v1_cars_path(cars)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0][:name]).to eq(cars[0][:name])
      expect(json[1][:name]).to eq(cars[1][:name])
      expect(json[2][:name]).to eq(cars[2][:name])
      expect(json[3][:name]).to eq(cars[3][:name])
      expect(json[4][:name]).to eq(cars[4][:name])
    end

    it 'none found' do
      get api_v1_cars_path(id: 2020)

      expect(response).to have_http_status(:not_found)
    end
  end
end