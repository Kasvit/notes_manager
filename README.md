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

### Useful Endpoints
```
Notes resources: http://localhost:3000/api/notes
Notes search: http://localhost:3000/api/notes/search?query=Rosenbaum
Generate notes from the mocked file: POST http://localhost:3000/api/notes/import

API logs list: http://localhost:3000/api/api_logs
API logs search: http://localhost:3000/api/api_logs/search?endpoint=/api/notes&request_method=GET&response_status=200

```

### Docker

```
docker-compose up
```