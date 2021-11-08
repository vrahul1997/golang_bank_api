postgres:
	sudo docker run --name postgres12 --network bank-network -p 8000:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=puneetha -d postgres:12-alpine

createdb:
	sudo docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	sudo docker exec -it postgres12 dropdb simple_bank

migratecreate:
	migrate create -ext sql -dir db/migration -seq init_schema

migrateup:
	migrate -path db/migration -database "postgresql://root:puneetha@localhost:8000/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:puneetha@localhost:8000/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/vrahul1997/golang_bank_api/db/sqlc Store

run_docker_container:
	sudo docker run --name simplebank --network bank-network -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE="postgresql://root:puneetha@postgres12/simple_bank?sslmode=disable" simplebank:latest

build_docker_image:
	sudo docker build -t simplebank:latest .


.PHONY: postgres createdb dropdb migratecreate migrateup migratedown sqlc test server mock run_docker_container build_docker_image