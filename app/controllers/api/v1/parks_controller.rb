class Api::V1::ParksController < ApplicationController
    skip_before_action :authorized

    def index 
        if current_user
            parks=Park.list_by_distance(current_user)
        else 
            parks=Park.all.sort_by{|park| park.name}
            distance=0
        end

        render json: parks.to_json( :include => [:features => {:only => :name}], :except => [:updated_at, :created_at, :address]), status: :accepted
    end

    def show 
        park=Park.find(params[:id])
        saved=park.saved_parks.map{|s_p| s_p.user}.include?(current_user)
        render json: {park: ParkSerializer.new(park), saved: saved} 
    end

end
