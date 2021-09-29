module Api
  module V1
    class FieldNotesController < ApiController
      before_action :set_field_note_id, only: %i[show update destroy]
      before_action :set_new_field_note, only: %i[create]

      def index
        field_notes = FieldNote.all
        render json: { data: field_notes.as_json(except: %i[id created_at updated_at]) }, status: :ok
      end

      def show
        field_note = FieldNote.find_by!(id: @field_note_id)
        render json: { data: field_note }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Parâmetros inválidos' }, status: :not_found
      end

      def update
        field_note = FieldNote.find_by!(id: @field_note_id)

        if field_note.update(field_note_params)
          render json: { data: field_note }, status: :ok
        else
          render json: { data: field_note.errors }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Parâmetros inválidos' }, status: :not_found
      end

      def create
        if @field_note.save
          render json: { data: @field_note }, status: :created
        else
          render json: { data: @field_note.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        field_note = FieldNote.find_by!(id: @field_note_id)

        field_note.destroy

        head :no_content
      end

      private

      def field_note_params
        params.require(:field_note).permit(:long_text, :user, :date, :latitude, :longitude)
      end

      def set_field_note_id
        @field_note_id = params[:id]
      end

      def set_new_field_note
        @field_note = FieldNote.new(field_note_params)
      end
    end
  end
end
