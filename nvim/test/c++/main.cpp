#include <iostream>
#include <string>
#include <vector>

using namespace std;

#define MAX_VALUE 100

namespace my_namespace {
struct User {
  int id;
  std::string name;
  bool is_active;
};

class MyClass {
public:
  int count = 0;

  MyClass(int initial_count) : count(initial_count) {}

  void increment() { count++; }

private:
  double ratio = 0.5;
};
} // namespace my_namespace

enum Color { RED = 1, GREEN = 2, BLUE = 3 };

template <typename T> T add(T a, T b) { return a + b; }

int main() {
  int x = 10;
  float y = 3.14;
  char c = 'A';
  string greeting = "Hello, C++!";

  if (x > 0) {
    std::cout << "x is positive" << std::endl;
  } else if (x == 0) {
    std::cout << "x is zero" << std::endl;
  } else {
    std::cout << "x is negative" << std::endl;
  }

  for (int i = 0; i < 5; i++) {
    std::cout << "Iteration: " << i << std::endl;
  }

  int j = 0;
  while (j < 3) {
    std::cout << "While loop: " << j << std::endl;
    j++;
  }

  // @keyword.repeat, @variable: Vòng lặp do-while
  int k = 0;
  do {
    std::cout << "Do-while loop: " << k << std::endl;
    k++;
  } while (k < 2);

  try {
    if (x == 0)
      throw std::runtime_error("Division by zero");
    int result = MAX_VALUE / x;
    std::cout << "Result: " << result << std::endl;
  } catch (const std::exception &e) {
    std::cerr << "Error: " << e.what() << std::endl;
  }

  my_namespace::MyClass obj(5); // @namespace, @type, @number
  obj.increment();              // @function.call

  std::vector<int> numbers = {
      1, 2, 3}; // @namespace, @type.builtin, @number, @punctuation.bracket

  int sum = add<int>(x, 7); // @type.builtin, @number
  std::cout << "Sum: " << sum << std::endl;

  switch (x) {
  case 10: // @keyword, @number
    std::cout << "x is 10" << std::endl;
    break; // @keyword
  default: // @keyword
    std::cout << "x is something else" << std::endl;
    break;
  }

  // @keyword.return, @number: Trả về giá trị
  return 0;
}

// @error: Dòng lỗi cú pháp
int error = "string"; // @type.builtin, @string
