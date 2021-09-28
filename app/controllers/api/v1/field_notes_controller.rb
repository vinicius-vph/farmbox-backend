module Api
  module V1
    class FieldNotesController < ActionController::API
      def index
        field_notes = FieldNote.all
        render json: { status: :success, data: field_notes }, status: :ok
      end

      def new
        field_note = FieldNote.new
        render json: { status: :success, data: field_note }, status: :ok
      end

      def show
        field_note = FieldNote.find(params[:id])
        render json: { status: :success, data: field_note }, status: :ok
      end

      def create
        field_note = FieldNote.new(field_note_params)

        if field_note.save
          render json: { status: :success, message: 'Anotação de Campo criada com sucesso', data: field_note },
                 status: :ok
        else
          render json: { status: :error, message: 'Não foi possivel criar nova anotação de campo',
                         data: field_note.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        field_note = FieldNote.find(params[:id])
        field_note.destroy
        render json: { status: :success, message: 'Anotação de Campo deletada com sucesso' }, status: :ok
      end

      private

      def field_note_params
        params.require(:field_note).permit(:long_text, :user, :date, :latitude, :longitude)
      end
    end
  end
end
