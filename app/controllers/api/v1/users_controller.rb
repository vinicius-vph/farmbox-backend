module Api
  module V1
    class UsersController < ApiController
      before_action :set_user_id, only: %i[show update destroy]
      before_action :set_new_user, only: %i[create]

      def show
        user = User.find_by!(id: @user_id)
        render json: { data: user.as_json(except: %i[id password_digest]) }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Parâmetros inválidos' }, status: :not_found
      end

      def update
        user = User.find_by!(id: @user_id)

        if user.update(user_params)
          render json: { data: user.as_json(except: %i[password_digest]) }, status: :ok
        else
          render json: { data: user.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Parâmetros inválidos' }, status: :not_found
      end

      def create
        if @user.save
          render json: { data: @user.as_json(except: %i[password_digest]) }, status: :created
        else
          render json: { data: @user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find_by!(id: @user_id)

        user.destroy

        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :password_digest)
      end

      def set_user_id
        @user_id = params[:id]
      end

      def set_new_user
        @user = User.new(user_params)
      end
    end
  end
end
