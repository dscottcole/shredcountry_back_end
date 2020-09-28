class BikesController < ApplicationController
    def index
        @bikes = Bike.all
        render json: @bikes.to_json(except: [:created_at, :updated_at])
    end
end
