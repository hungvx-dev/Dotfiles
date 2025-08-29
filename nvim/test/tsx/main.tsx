import React, { useState, useEffect, useCallback } from "react";
import _, { debounce } from "lodash"; // @function.builtin

const globalVar: string = "Global"; // @type.builtin, @string

interface User {
  name: string;
  age: number;
  isActive: boolean;
}

type Role = "admin" | "user" | "guest";
const a: Role;

enum Status {
  Active = 1,
  Inactive = 0,
  Pending = 2,
}

module MyModule {
  export const moduleVar: number = 42;
}

namespace MyNamespace {
  export interface Config {
    id: number; // @property, @type.builtin
  }
}

function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key]; // @keyword.return, @operator
}

async function fetchData(url: string): Promise<string> {
  const response = await fetch(url);
  return response.text();
}

export class MyClass {
  constructor() {}
  test() {}
}

export default function FullTypeScriptComponent(props: User) {
  const [count, setCount] = useState<number>(0);
  const [searchTerm, setSearchTerm] = useState<string>("");

  const TEST = 1;
  console.log(TEST);
  let temp: any = 10;
  temp = "string" as string;

  const maxCount: number = 100;

  var oldStyleVar: boolean = true;

  useEffect(() => {
    try {
      if (count === 0) throw new Error("Count is zero");
    } catch (error: unknown) {
      console.error("Caught error:", error);
    } finally {
      console.log("Effect cleanup"); // @function.builtin
    }
  }, [count]); // @punctuation.bracket

  const handleSearch = useCallback(
    debounce((term: string) => {
      setSearchTerm(term); // @function.call
    }, 300),
    [], // @punctuation.bracket
  );

  // @keyword.if, @keyword.conditional: Câu lệnh if
  if (count > maxCount) {
    console.log("Count exceeded"); // @function.builtin
  } else if (count === maxCount) {
    console.warn("Count at max");
  } else {
    console.info("Count is safe");
  }

  for (let i = 0; i < 5; i++) {
    console.log(`Loop ${i}`);
  }

  while (count < 3) {
    setCount(count + 1);
    break;
  }

  do {
    continue;
  } while (false);

  switch (props.age) {
    case 25:
      console.log("Age is 25");
      break;
    default:
      console.log("Other age");
  }

  return (
    <div>
      <h1 className="title">Xin chào, {props.name}!</h1>
      <h2 className="title">Xin chào, {props.name}!</h2>
      <a>Tuổi: {props.age}</a>
      <p>Trạng thái: {props.isActive ? "Có" : "Không"}</p>
      <button onClick={() => setCount(count + 1)}>Nhấn tôi</button>
      <p>Số lần nhấn: {count}</p>
      <p>Tỷ lệ: {(count / maxCount).toFixed(2)}</p>
      <p>Regex: {"/[a-z]+/"}</p>
    </div>
  );
}

type InferType<T> = T extends infer R ? R : never;

const assertedVar = "test" as const;

const errorVar: number = "string";

const obj = { key: "value" } as any;
delete obj.key;

const typeCheck: string = typeof count;

const isError: boolean = errorVar instanceof Error;

const hasKey: boolean = "key" in obj;

const newInstance = new Date();

function useThis(this: User) {
  console.log(this.name);
}

function* generator(): Generator<number> {
  yield 1;
  yield 2;
}
