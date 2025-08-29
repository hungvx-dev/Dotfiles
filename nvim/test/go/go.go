package main // @keyword.package, @module

import ( // @keyword.import, @punctuation.bracket
	"fmt"     // @string
	"os"      // @string
	"strings" // @string
)

// @keyword.const, @constant: Định nghĩa hằng số
const MaxCount = 100 // @number

// @keyword.type, @type.definition: Định nghĩa struct
type User struct { // @type
	// @property, @type.builtin: Thuộc tính kiểu string
	Name string
	// @property, @type.builtin: Thuộc tính kiểu int
	Age int
	// @property, @type.builtin: Thuộc tính kiểu bool
	IsActive bool
}

// @keyword.type, @type.definition: Định nghĩa interface
type Printer interface { // @type
	// @function, @variable.parameter: Phương thức trong interface
	Print() string // @type.builtin
}

// @keyword.func, @function: Định nghĩa hàm
func add(a, b int) int { // @variable.parameter, @type.builtin
	return a + b // @keyword.return, @operator
}

// @keyword.func, @function.method: Phương thức của struct
func (u User) Print() string { // @variable.parameter, @type.builtin
	return fmt.Sprintf("Name: %s, Age: %d", u.Name, u.Age) // @function.call, @string
}

// @keyword.func, @function: Hàm chính
func main() {
	// @keyword.var, @variable: Khai báo biến
	var count int = 10 // @type.builtin, @number
	count = 20         // @number

	// @keyword.const, @variable: Khai báo hằng số cục bộ
	const localConst = 42 // @number

	// @keyword.if, @keyword.conditional: Câu lệnh if
	if count > MaxCount { // @operator
		fmt.Println("Count exceeded") // @function.call, @string
	} else if count == MaxCount { // @keyword.else, @operator
		fmt.Println("Count at max") // @function.call, @string
	} else { // @keyword.else
		fmt.Println("Count is safe") // @function.call, @string
	}

	// @keyword.for, @keyword.repeat: Vòng lặp for
	for i := 0; i < 5; i++ { // @variable, @number, @operator
		fmt.Printf("Loop %d\n", i) // @function.call, @string
		if i == 3 { // @operator
			break // @keyword.break
		}
		continue // @keyword.continue
	}

	// @keyword.for, @keyword.repeat: Vòng lặp for như while
	for count > 0 { // @operator
		count-- // @operator
	}

	// @keyword.chan, @type.builtin: Khai báo channel
	ch := make(chan int) // @function.builtin, @type.builtin

	// @keyword.go, @function.call: Khởi chạy goroutine
	go func() { // @punctuation.bracket
		defer close(ch) // @keyword.defer, @function.call
		ch <- 42        // @operator, @number
	}()

	// @keyword.select, @keyword.conditional: Câu lệnh select
	select { // @punctuation.bracket
	case val := <-ch: // @keyword.case, @variable, @operator
		fmt.Println("Received:", val) // @function.call, @string
	default: // @keyword.default
		fmt.Println("No value received") // @function.call, @string
	}

	// @keyword.switch, @keyword.conditional: Câu lệnh switch
	switch count { // @variable
	case 0: // @keyword.case, @number
		fmt.Println("Count is zero") // @function.call, @string
		fallthrough // @keyword.fallthrough
	case 20: // @keyword.case, @number
		fmt.Println("Count is 20") // @function.call, @string
	default: // @keyword.default
		fmt.Println("Other count") // @function.call, @string
	}

	// @keyword.type, @variable: Khai báo biến với type assertion
	var anyVal interface{} = "test" // @type.builtin, @string
	if str, ok := anyVal.(string); ok { // @keyword.if, @type.builtin, @operator
		fmt.Println("Type asserted:", str) // @function.call, @string
	}

	// @keyword.map, @type.builtin: Khai báo map
	users := map[string]int{ // @type.builtin, @string, @number
		"Alice": 25,
		"Bob":   30,
	} // @punctuation.bracket

	// @keyword.range, @keyword.repeat: Vòng lặp range
	for name, age := range users { // @variable
		fmt.Printf("%s: %d\n", name, age) // @function.call, @string
	}

	// @keyword.goto, @label: Sử dụng goto
	if count < 0 {
		goto ErrorLabel // @keyword.goto
	}

	// @keyword.return: Trả về giá trị
	return

ErrorLabel: // @label
	fmt.Println("Error occurred") // @function.call, @string
}

// @error: Dòng lỗi cú pháp
var errorVar int = "string" // @type.builtin, @string
