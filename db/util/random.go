package util

import (
	"math/rand"
	"time"

	"github.com/goombaio/namegenerator"
)

// init function usually run in the beginning of the application initialisation
func init() {
	rand.Seed(time.Now().UnixNano())
}

// function for random integer generation
func RandomInit(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

// function for generating random characters
func RandomString() string {
	seed := time.Now().UnixNano()
	generator := namegenerator.NewNameGenerator(seed)
	name := generator.Generate()
	return name
}

// This function generates random owner
func RandomOwner() string {
	return RandomString()
}

// func for random money generation
func RandomBalance() int64 {
	return RandomInit(0, 1000)
}

// func for RandomCurrency
func RandomCurrency() string {
	currencies := []string{"USD", "EUR", "CAD"}
	n := len(currencies)
	return currencies[rand.Intn(n)]

}
