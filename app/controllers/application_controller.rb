class ApplicationController < ActionController::API
    before_action :authorized, except: [:fallback_index_html]

    def fallback_index_html
        render :file => 'public/index.html'
    end

    def encode_token(payload)
        # payload => { beef: 'steak' }
        JWT.encode(payload, 'my_s3cr3t')
        # jwt string: "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"
    end
     
    def auth_header
        # { 'Authorization': 'Bearer <token>' }
        request.headers['Authorization']
    end
     
    def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          # headers: { 'Authorization': 'Bearer <token>' }
          begin
            JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
            # JWT.decode => [{ "beef"=>"steak" }, { "alg"=>"HS256" }]
          rescue JWT::DecodeError
            nil
          end
        end
    end

    def current_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def check_user
        if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
        end
        token = encode_token({ user_id: @user.id })
        render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
    end
         
    def logged_in?
        !!current_user
    end

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end

end

# SAMPLE FETCH WITH HEADER FOR AUTHORIZATION
# fetch('http://localhost:3000/api/v1/profile', {
#   method: 'GET',
#   headers: {
#     Authorization: `Bearer <token>`
#   }
# })