module Api
  module V1
    class UsersController < ActionController::API
      before_action :set_user, only: %i[show update destroy]
      before_action :set_new_user, only: %i[create]

      def show
        render json: { message: 'Usuário encontrado com sucesso',
                       data: @user.as_json(except: %i[id password_digest]) }, status: :ok
      end

      def update
        if @user.update(user_params)
          render json: { message: 'Usuário atualizado com sucesso',
                         data: @user.as_json(except: %i[password_digest]) }, status: :ok
        else
          render json: { message: 'Não foi possivel atualizar o usuário',
                         data: @user.errors }, status: :unprocessable_entity
        end
      end

      def create
        if @user.save
          render json: { message: 'Usuário criado com sucesso',
                         data: @user.as_json(except: %i[id password_digest]) }, status: :created
        else
          render json: { message: 'Não foi possivel criar o usuário',
                         data: @user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :password_digest)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def set_new_user
        @user = User.new(user_params)
      end
    end
  end
end
