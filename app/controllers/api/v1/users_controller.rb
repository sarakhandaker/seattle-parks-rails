require 'rest-client'
require 'json'

class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def profile

#         fetch('http://localhost:3000/api/v1/profile', {
#           method: 'GET',
#           headers: {
#            Authorization: `Bearer <token>`
#            }
#          })

    url = 'https://www.metaweather.com/api/location/'+'2490383/'
    response = RestClient.get(url)
    weather=JSON.parse(response)

        render json: { user: UserSerializer.new(current_user), weather: weather}, status: :accepted
    end

    def create
      @user = User.create(user_params)
      if @user.valid?
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
      else
        render json: { error: @user.errors }, status: :not_acceptable
      end
    end
   
    private
    def user_params
      params.require(:user).permit(:username, :password, :bio, :email, :address)
    end
  end
