# README

A simplified backend service for a note-taking application using Ruby
on Rails, focusing on API development, data storage, and background processing.

# How to:
### Run local environment:
```
bundle install
export DATABASE_USERNAME={...}
export DATABASE_PASSWORD={...}

rails db:setup
rails s
```

Also, you can send a POST request to `/api/notes/import` and generate mocked notes. 