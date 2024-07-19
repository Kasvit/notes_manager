# frozen_string_literal: true

json.type 'note'
json.id   note.id
json.attributes do
  json.title note.title
  json.content note.content
end
