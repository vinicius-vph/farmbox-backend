module Api
  module V1
    class UsersController < ActionController::API
      def index
        user = User.all
        render json: { status: :success, data: user.as_json(except: %i[password_digest]) }, status: :ok
      end

      def new
        user = User.new
        render json: { status: :success, data: user.as_json(except: %i[password_digest]) }, status: :ok
      end

      def show
        user = User.find(params[:id])
        render json: { status: :success, data: user.as_json(except: %i[password_digest]) }, status: :ok
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: { status: :success, message: 'Usuário criado com sucesso', data: user.as_json(except: %i[password_digest]) }, status: :ok
        else
          render json: { status: :error, message: 'Não foi possivel criar o usuário',
                         data: user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
        render json: { status: :success, message: 'Usuário deletado com sucesso' }, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:email, :password_digest, :password_digest_confirmation)
      end
    end
  end
end
