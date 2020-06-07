class Api::V1::SavedParksController < ApplicationController

    def create
      @save_park = SavedPark.create(user_id: saved_parks_params[:user_id].to_i, park_id: saved_parks_params[:park_id].to_i)
        render json: { saved_park: @save_park }, status: :not_acceptable

    end
   
    def destroy
        SavedPark.find(params[:id]).destroy
    end

    private
    def saved_parks_params
      params.require(:saved_park).permit(:user_id, :park_id)
    end
  end
