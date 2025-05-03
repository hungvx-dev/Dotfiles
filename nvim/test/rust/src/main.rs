mod my_module {
    pub const MAX_COUNT: i32 = 100;

    pub struct User {
        name: String,
        age: i32,
        active: bool,
    }

    impl User {
        pub fn new(name: String, age: i32) -> Self {
            Self { name, age, active: true }
        }

        pub fn greet(&self) -> String {
            format!("Hello, {}!", self.name)
        }
    }

    // @keyword.trait, @type.definition: Định nghĩa trait
    pub trait Printable {
        // @function, @variable.parameter: Phương thức trong trait
        fn print(&self) -> String; // @type.builtin
    }

    // @keyword.impl, @keyword.for: Triển khai trait
    impl Printable for User {
        fn print(&self) -> String { // @keyword.fn, @function.method
            self.greet() // @function.call
        }
    }
}

// @keyword.use: Import từ module
use my_module::{User, Printable, MAX_COUNT}; // @type, @constant

// @keyword.fn, @function: Hàm generic
fn add<T: std::ops::Add<Output = T>>(a: T, b: T) -> T { // @variable.parameter, @type, @namespace
    a + b // @operator
}

// @keyword.fn, @function: Hàm chính
fn main() {
    // @keyword.let, @variable: Khai báo biến
    let mut count = 10; // @keyword.mut, @number
    count = 20; // @number

    // @keyword.const, @variable: Khai báo hằng số
    const LOCAL_CONST: i32 = 42; // @type.builtin, @number

    // @keyword.if, @keyword.conditional: Câu lệnh if
    if count > MAX_COUNT { // @operator
        println!("Count exceeded"); // @function.call, @string
    } else if count == MAX_COUNT { // @keyword.else, @operator
        println!("Count at max"); // @function.call, @string
    } else { // @keyword.else
        println!("Count is safe"); // @function.call, @string
    }

    // @keyword.loop, @keyword.repeat: Vòng lặp loop
    loop {
        if count <= 0 { // @operator
            break; // @keyword.break
        }
        count -= 1; // @operator
        continue; // @keyword.continue
    }

    // @keyword.for, @keyword.repeat: Vòng lặp for
    for i in 0..5 { // @variable, @number, @operator
        println!("Loop {}", i); // @function.call, @string
    }

    // @keyword.while, @keyword.repeat: Vòng lặp while
    while count < 25 { // @operator
        count += 1; // @operator
    }

    // @keyword.match, @keyword.conditional: Câu lệnh match
    match count { // @variable
        20 => println!("Count is 20"), // @number, @function.call, @string
        n if n > 0 => println!("Positive: {}", n), // @variable, @operator, @function.call, @string
        _ => println!("Other"), // @keyword._, @function.call, @string
    }

    // @keyword.async, @keyword.fn: Hàm async
    async fn fetch_data() -> String { // @type.builtin
        String::from("Data") // @namespace, @function.call, @string
    }

    // @keyword.await: Gọi hàm async trong block async
    let future = async {
        fetch_data().await // @keyword.await, @function.call
    };

    // @keyword.unsafe: Khối mã không an toàn
    unsafe {
        let ptr: *const i32 = &count; // @type.builtin, @operator
        println!("Raw pointer: {}", *ptr); // @function.call, @string, @operator
    }

    // @keyword.let, @variable: Khai báo biến với type assertion
    let user: User = User::new(String::from("Alice"), 30); // @function.call, @string, @number
    let message = user.print(); // @function.call

    // @keyword.enum, @type.definition: Định nghĩa enum
    enum Status {
        Active,
        Inactive(i32), // @type.builtin
    }

    // @keyword.static, @variable: Biến static
    static GLOBAL: i32 = 99; // @type.builtin, @number

    // @keyword.move, @keyword.fn: Closure với move
    let closure = move || println!("Count: {}", count); // @function.call, @string
    closure(); // @function.call

    // @keyword.return: Trả về giá trị
    return;
}

// @error: Dòng lỗi cú pháp
let error_var: i32 = "string"; // @type.builtin, @string
