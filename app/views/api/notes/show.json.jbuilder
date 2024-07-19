# frozen_string_literal: true

json.data do
  json.partial! partial: 'api/notes/note', locals: { note: @note }
end
