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
      puts 'teste'

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

  context 'create' do
      it 'shoud create a car' do 
      subsidiary = create(:subsidiary)
      car_model = create(:car_model)

      expect{post api_v1_cars_path, 
                  params: {car_km: 0, color: 'Azul', 
                            license_plate: 'ABC-1234', 
                            subsidiary_id: subsidiary.id, 
                            car_model_id: car_model.id }}.to change(Car, :count).by(1)
      
      expect(response).to have_http_status(:created)
      car = Car.last 
      expect(car.license_plate).to eq('ABC-1234')
    end

    it 'and try to create a empty object' do
      post api_v1_cars_path, params: {}

      expect(response).to have_http_status(412)
    end

    it 'and have erro 500' do
      car = create(:car)
      subsidiary = create(:subsidiary)
      car_model = create(:car_model)

      allow(car).to receive(:save!).and_return('error')

      post api_v1_cars_path, params: {car_km: 0, color: 'Azul', 
                             license_plate: 'ABC-1234', 
                             subsidiary_id: subsidiary.id, 
                             car_model_id: car_model.id }

      expect(response).to have_http_status(500)
    end

  end

  context 'update' do
    it 'should update a car' do
      car = create(:car)
      new_subsidiary = create(:subsidiary)
      new_car_model = create(:car_model)

      patch api_v1_car_path(car), params: {car_km: 99, color: 'Preto', 
                                            license_plate: 'YXZ-6789', 
                                            subsidiary_id: new_subsidiary.id, 
                                            car_model_id: new_car_model.id }

      car.reload

      expect(response).to have_http_status(:ok)
      expect(car.license_plate).to eq 'YXZ-6789'
      expect(car.car_km).to eq 99
      expect(car.color).to eq 'Preto'
      expect(car.subsidiary_id).to eq new_subsidiary.id
      expect(car.car_model_id).to eq new_car_model.id
    end

    it 'and fail if not all fields are filled' do
      car = create(:car)

      patch api_v1_car_path(car), params: { color: nil}

      expect(response).to have_http_status(412)
    end
  end
end