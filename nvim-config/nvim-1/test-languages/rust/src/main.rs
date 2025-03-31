struct Student {
  name: String,
  age: u8,
}

impl Student {
  fn new(name: String, age: u8) -> Self {
    Self { name, age }
  }
}
fn main() {
  let student = Student {
    name: String::from("123"),
    age: 12,
  };

  let i: i8 = 1;
  let student1 = Student::new(String::from("12"), 12);
}
