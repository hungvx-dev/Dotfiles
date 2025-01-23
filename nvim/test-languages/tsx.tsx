import React, { useState, useEffect, useContext, createContext } from "react";

// Type definition for props
interface GreetingProps {
  name: string;
  age?: number; // Optional property
}

// Type alias
type Theme = "light" | "dark";

declare function getGreeting(name: string): string;

declare const APP_NAME: string;

// Function declaration
function add(a: number, b: number): number {
  return a + b;
}

// Context for theme
const ThemeContext = createContext<Theme>("light");

// Functional component
const Greeting: React.FC<GreetingProps> = ({ name, age }) => {
  const theme = useContext(ThemeContext);
  const [counter, setCounter] = useState<number>(0);

  useEffect(() => {
    console.log(`Hello, ${name}! You are ${age ?? "ageless"}.`);
  }, [name, age]);

  const handleClick = (): void => {
    setCounter((prev) => prev + 1);
  };

  // Example of switch
  const getCounterLabel = (): string => {
    switch (counter) {
      case 0:
        return "No clicks yet";
      case 1:
        return "Clicked once";
      default:
        return `Clicked ${counter} times`;
    }
    // while
    // if()
  };

  return (
    <div style={{ backgroundColor: theme === "light" ? "#fff" : "#333", color: theme === "light" ? "#000" : "#fff" }}>
      <h1>Hello, {name}!</h1>
      {age && <p>Age: {age}</p>}
      <p>Counter: {counter}</p>
      <p>{getCounterLabel()}</p>
      <button onClick={handleClick}>Increase Counter</button>
    </div>
  );
};

// Class component
class App extends React.Component<{}, { theme: Theme }> {
  constructor(props: {}) {
    super(props);
    this.state = {
      theme: "light",
    };
  }

  toggleTheme = (): void => {
    this.setState((prevState) => ({ theme: prevState.theme === "light" ? "dark" : "light" }));
  };

  render(): JSX.Element {
    // Example of for loop
    const numbers: number[] = [1, 2, 3, 4, 5];
    const doubledNumbers = [];
    for (let i = 0; i < numbers.length; i++) {
      doubledNumbers.push(numbers[i] * 2);
    }

    if (doubledNumbers.length) {
      console.log(123);
    }

    // Example of while loop
    let count = 0;
    while (count < 3) {
      console.log(`Count is: ${count}`);
      count++;
    }

    // Example of if statement
    const isThemeLight = this.state.theme === "light";

    return (
      <ThemeContext.Provider value={this.state.theme}>
        <div>
          <button onClick={this.toggleTheme}>Toggle Theme</button>
          <p>{isThemeLight ? "Light mode is on" : "Dark mode is on"}</p>
          <Greeting name="John Doe" age={30} />
          <ul>
            {doubledNumbers.map((num, index) => (
              <li key={index}>{num}</li>
            ))}
          </ul>
        </div>
      </ThemeContext.Provider>
    );
  }
}

// TypeScript utility types usage
interface User {
  id: number;
  name: string;
  email: string;
}

type PartialUser = Partial<User>;
type ReadonlyUser = Readonly<User>;
type UserWithoutEmail = Omit<User, "email">;

type ApiResponse<T> = {
  data: T;
  error?: string;
};

// Enum example
enum Status {
  Active = "ACTIVE",
  Inactive = "INACTIVE",
  Suspended = "SUSPENDED",
}

// Generic function
function wrapInArray<T>(value: T): T[] {
  const a: PartialUser | ReadonlyUser | UserWithoutEmail | ApiResponse<any> | any = 1;
  return [value];
}
console.log(wrapInArray, Status, add, addEventListener, getGreeting, APP_NAME);

export default App;
