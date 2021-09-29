module Api
  module V1
    class FieldNotesController < ActionController::API
      before_action :set_field_note, only: %i[show update destroy]
      before_action :set_new_field_note, only: %i[create]

      def index
        field_notes = FieldNote.all
        render json: { data: field_notes.as_json(except: %i[id created_at updated_at]) }, status: :ok
      end

      def show
        render json: { message: 'Anotação de Campo encontrada com sucesso',
                       data: @field_note.as_json(except: %i[id]) }, status: :ok
      end

      def update
        if @field_note.update(field_note_params)
          render json: { message: 'Anotação de Campo  atualizada com sucesso',
                         data: @field_note.as_json(except: %i[id]) }, status: :ok
        else
          render json: { message: 'Não foi possivel atualizar o Anotação de Campo',
                         data: @field_note.errors }, status: :unprocessable_entity
        end
      end

      def create
        if @field_note.save
          render json: { message: 'Anotação de Campo criada com sucesso',
                         data: @field_note.as_json(except: %i[id]) }, status: :created
        else
          render json: { message: 'Não foi possivel criar nova anotação de campo',
                         data: @field_note.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @field_note.destroy
        head :no_content
      end

      private

      def field_note_params
        params.require(:field_note).permit(:long_text, :user, :date, :latitude, :longitude)
      end

      def set_field_note
        @field_note = FieldNote.find(params[:id])
      end

      def set_new_field_note
        @field_note = FieldNote.new(field_note_params)
      end
    end
  end
end
