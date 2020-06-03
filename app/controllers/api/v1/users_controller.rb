class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def profile

#         fetch('http://localhost:3000/api/v1/profile', {
#           method: 'GET',
#           headers: {
#            Authorization: `Bearer <token>`
#            }
#          })

        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def create

        #SAMPLE POST REQUEST
        # fetch('http://localhost:3000/api/v1/users', {
        #     method: 'POST',
        #     headers: {
        #       'Content-Type': 'application/json',
        #       Accept: 'application/json'
        #     },
        #     body: JSON.stringify({
        #       user: {
        #         username: "sylviawoods",
        #         password: "whatscooking",
        #         bio: "Sylvia Woods was an American restaurateur who founded the sould food restaurant Sylvia's in Harlem on Lenox Avenue, New York City in 1962. She published two cookbooks and was an important figure in the community."
        #       }
        #     })
        #   })
        #     .then(r => r.json())

      @user = User.create(user_params)
      if @user.valid?
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
      else
        render json: { error: 'failed to create user' }, status: :not_acceptable
      end
    end
   
    private
    def user_params
      params.require(:user).permit(:username, :password, :bio, :email, :address)
    end
  end
