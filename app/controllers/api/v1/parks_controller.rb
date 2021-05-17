class Api::V1::ParksController < ApplicationController
    skip_before_action :authorized

    def index 
        if current_user
            # parks=Park.list_by_distance(current_user).paginate(:page => params[:page], per_page: 50)
            parks=Park
        else 
            parks=Park.paginate(:page => params[:page], per_page: 30, , order: 'name')
        end
        render json: parks.to_json( :methods => [:visit_length, :avg_rating], :include => [:features => {:only => :name}], :except => [:updated_at, :created_at, :address]), status: :accepted
    end

    def search
        parks=Park.all
        if (params[:name].length !=0)
            parks=parks.select{|park| park.name.include?(params[:name].upcase)}
        end
        if (params[:neigh] != "All")
            parks=parks.select{|park| park.neighborhood == params[:neigh]}
        end
        if (params[:feat].length !=0)
            features= params[:feat].split(",")
            features.each {|feat| parks=parks.select{|park| park.features.map{|feat| feat.name}.include?(feat)} }
        end
        render json: parks.to_json( :methods => [:visit_length, :avg_rating], :include => [:features => {:only => :name}], :except => [:updated_at, :created_at, :address]), status: :accepted
    end

    def show 
        park=Park.find(params[:id])
        saved=park.saved_parks.map{|s_p| s_p.user}.include?(current_user)
        render json: {park: ParkSerializer.new(park), saved: saved} 
    end

end
