docker login
docker-compose up -d --build
docker-compose exec server flask db init
docker-compose exec server flask db migrate -m "first migration"
docker-compose exec server flask db upgrade

docker-compose up


