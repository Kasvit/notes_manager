# frozen_string_literal: true

module Api
  class NotesController < ApiController
    def index
      @notes = Note.all
    end

    def show
      @note = Note.find(params[:id])
    end

    def create
      @note = Note.new(note_params)
      if @note.save
        render :show, status: :created
      else
        validation_error(@note)
      end
    end

    def update
      @note = Note.find(params[:id])
      if @note.update(note_params)
        render :show
      else
        validation_error(@note)
      end
    end

    def destroy
      @note = Note.find(params[:id])
      @note.destroy
      head :no_content
    end

    def search
      @notes = Note.search(params[:query])
    end

    private

    def note_params
      params.require(:note).permit(:title, :content)
    end
  end
end
