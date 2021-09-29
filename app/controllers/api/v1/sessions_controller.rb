module Api
  module V1
    class SessionsController < ActionController::API
      def create
        user = User.find_by(email: params[:user][:email])
                   .try(:authenticate, params[:user][:password_digest])
        if user
          session[:user_id] = user.id

          render json: {
            status: :created,
            logged_in: true,
            user: user
          }
        else
          render json: { status: 401 }
        end
      end
    end
  end
end
