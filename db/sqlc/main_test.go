package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

// We are assigning it here in order to reuse it.
var testQueries *Queries
var testdbConn *sql.DB

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:puneetha@localhost:8000/simple_bank?sslmode=disable"
)

func TestMain(m *testing.M) {
	var err error
	testdbConn, err = sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}

	testQueries = New(testdbConn)

	os.Exit(m.Run())

}
