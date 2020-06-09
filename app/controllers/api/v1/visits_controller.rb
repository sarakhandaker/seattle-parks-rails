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
        @visit = Visit.find(params[:id])
        if @visit.update(visit_params)
          render json: @visit, status: :created
        else
          render json: { error: @visit.errors }, status: :not_acceptable
        end
    end

    def destroy
      Visit.find(params[:id]).destroy
    end

    private
 
    def visit_params
      params.require(:visit).permit(:rating, :user_id, :park_id, :comment, :date)
    end

end