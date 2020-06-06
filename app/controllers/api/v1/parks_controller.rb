class Api::V1::ParksController < ApplicationController
    skip_before_action :authorized

    def index 
        parks=Park.all
        render json: parks.to_json( :include => [:features => {:only => :name}], :except => [:updated_at, :created_at, :address]), status: :accepted
    end

    def show 
        park=Park.find(params[:id])
        render json: {park: ParkSerializer.new(park)} 
    end

end
