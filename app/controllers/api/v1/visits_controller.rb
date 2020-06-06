class Api::V1::VisitsController < ApplicationController

    def create 
        @visit = Visit.create(visit_params)
        if @visit.valid?
          render json: @visit, status: :created
        else
          render json: { error: @visit.errors }, status: :not_acceptable
        end
    end

    def update 
        
    end

    private
 
    def visit_params
      params.require(:visit).permit(:rating, :user_id, :park_id, :comment, :date)
    end

end