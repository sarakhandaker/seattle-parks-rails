class Api::V1::ParksController < ApplicationController
    skip_before_action :authorized

    def index 
        parks=Park.all
        render json: parks.to_json( :include => [:features => {:only => :name}] ), status: :accepted
    end

    def show 
        # park=Park.find()
        render json: ParkSerializer.new(park), status: :accepted
    end

end
