# frozen_string_literal: true

json.data do
  json.array! @notes, partial: 'api/notes/note', as: :note
end
