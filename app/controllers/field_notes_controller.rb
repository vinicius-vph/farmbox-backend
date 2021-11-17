class FieldNotesController < ApplicationController
  def index
    @field_notes = FieldNote.all
  end

  def show
    @field_note = FieldNote.find(params[:id])
  end
end
