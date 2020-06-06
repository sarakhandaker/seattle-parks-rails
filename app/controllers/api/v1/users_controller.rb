class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def profile

#         fetch('http://localhost:3000/api/v1/profile', {
#           method: 'GET',
#           headers: {
#            Authorization: `Bearer <token>`
#            }
#          })

        render json: { user: UserSerializer.new(current_user)}, status: :accepted
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
