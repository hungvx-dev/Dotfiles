// Package declaration
package main

import (
	"errors"
	"fmt"
)

// Struct declaration
type User struct {
	ID    int
	Name  string
	Email string
}

// Interface declaration
type Greeter interface {
	Greet() string
}

// Enum-like constants
const (
	StatusActive    = "ACTIVE"
	StatusInactive  = "INACTIVE"
	StatusSuspended = "SUSPENDED"
)

// Function declaration
func add(a int, b int) int {
	return a + b
}

// Method implementation for struct
func (u User) Greet() string {
	return fmt.Sprintf("Hello, %s!", u.Name)
}

// Generic-like function using empty interface
func wrapInSlice(value interface{}) []interface{} {
	return []interface{}{value}
}

func main() {
	// Variable declaration
	name := "John Doe"
	age := 30

	// Slice and map
	numbers := []int{1, 2, 3, 4, 5}
	doubledNumbers := make([]int, len(numbers))

	// For loop
	for i, num := range numbers {
		doubledNumbers[i] = num * 2
	}

	// While-like loop (Go uses "for")
	count := 0
	for count < 3 {
		fmt.Println("Count is:", count)
		count++
	}

	// If statement
	if age > 18 {
		fmt.Println("You are an adult.")
	} else {
		fmt.Println("You are a minor.")
	}

	// Switch statement
	switch age {
	case 18:
		fmt.Println("You just became an adult.")
	case 30:
		fmt.Println("You are in your prime.")
	default:
		fmt.Println("Age is just a number.")
	}

	// Error handling
	result, err := divide(10, 0)
	if err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("Result:", result)
	}

	// Struct usage
	user := User{
		ID:    1,
		Name:  name,
		Email: "johndoe@example.com",
	}
	fmt.Println(user.Greet())

	// Using the generic-like function
	wrapped := wrapInSlice(42)
	fmt.Println("Wrapped value:", wrapped)
}

// Function with error handling
func divide(a int, b int) (int, error) {
	if b == 0 {
		return 0, errors.New("cannot divide by zero")
	}
	return a / b, nil
}
