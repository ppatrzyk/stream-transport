# Stream Transport

![flow](flow.drawio.svg)

```
# Create DB
mix ecto.create
mix ecto.migrate

# Build docker image
docker build -t stream_transport .

# RUN
docker-compose up
```
