class Api::V1::ParksController < ApplicationController
    skip_before_action :authorized

    def index 
        parks=Park.all
        render json: parks.to_json( :include => [:features => {:only => :name}], :except => [:updated_at, :created_at, :address]), status: :accepted
    end

    def show 
        park=Park.find(params[:id])
        saved=park.saved_parks.map{|s_p| s_p.user}.include?(current_user)
        render json: {park: ParkSerializer.new(park), saved: saved} 
    end

end
