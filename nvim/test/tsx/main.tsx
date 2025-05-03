import React, { useState, useEffect, useCallback } from 'react';
import _, { debounce } from 'lodash'; // @function.builtin

const globalVar: string = "Global"; // @type.builtin, @string

interface User {
  name: string;
  age: number;
  isActive: boolean;
}

type Role = 'admin' | 'user' | 'guest'; // @type.literal
const a: Role

enum Status {
  Active = 1,
  Inactive = 0,
  Pending = 2,
}

// @keyword.module: Định nghĩa module (namespace)
module MyModule {
  // @keyword.export, @variable: Xuất biến trong module
  export const moduleVar: number = 42; // @type.builtin, @number
}

// @keyword.namespace: Định nghĩa namespace
namespace MyNamespace {
  // @keyword.export, @type.definition: Định nghĩa interface trong namespace
  export interface Config {
    id: number; // @property, @type.builtin
  }
}

// @keyword.function, @function: Hàm generic với infer
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key]; // @keyword.return, @operator
}

// @keyword.function, @function: Hàm async
async function fetchData(url: string): Promise<string> {
  const response = await fetch(url); // @keyword, @function.builtin
  return response.text(); // @keyword.return
}

export default function FullTypeScriptComponent(props: User) {
  const [count, setCount] = useState<number>(0);
  const [searchTerm, setSearchTerm] = useState<string>('');

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
    [] // @punctuation.bracket
  );

  // @keyword.if, @keyword.conditional: Câu lệnh if
  if (count > maxCount) {
    console.log("Count exceeded"); // @function.builtin
  } else if (count === maxCount) { // @keyword.else, @operator
    console.warn("Count at max"); // @function.builtin
  } else { // @keyword.else
    console.info("Count is safe"); // @function.builtin
  }

  // @keyword.for, @keyword.repeat: Vòng lặp for
  for (let i = 0; i < 5; i++) {
    console.log(`Loop ${i}`); // @string, @punctuation
  }

  // @keyword.while, @keyword.repeat: Vòng lặp while
  while (count < 3) {
    setCount(count + 1); // @function.call, @operator
    break; // @keyword.break
  }

  // @keyword.do, @keyword.repeat: Vòng lặp do-while
  do {
    console.log("Do-while running"); // @function.builtin
    continue; // @keyword.continue
  } while (false); // @constant.builtin

  // @keyword.switch, @keyword.conditional: Câu lệnh switch
  switch (props.age) {
    case 25: // @keyword.case, @number
      console.log("Age is 25"); // @function.builtin
      break; // @keyword.break
    default: // @keyword.default
      console.log("Other age"); // @function.builtin
  }

  // @keyword.with: Sử dụng with (ít dùng, không khuyến khích)
  with (props) {
    console.log(name); // @property
  }

  // @keyword.return: Trả về JSX
  return (
    // @tag, @punctuation.bracket: Thẻ div
    <div>
      {/* @tag, @tag.attribute, @string: Thẻ h1 */}
      <h1 className="title">Xin chào, {props.name}!</h1>
      {/* @tag, @string: Hiển thị tuổi */}
      <p>Tuổi: {props.age}</p>
      {/* @tag, @string, @operator: Hiển thị trạng thái */}
      <p>Trạng thái: {props.isActive ? "Có" : "Không"}</p>
      {/* @tag, @tag.attribute, @function.call: Nút bấm */}
      <button onClick={() => setCount(count + 1)}>Nhấn tôi</button>
      {/* @tag, @string: Hiển thị count */}
      <p>Số lần nhấn: {count}</p>
      {/* @tag, @string, @float: Hiển thị tỷ lệ */}
      <p>Tỷ lệ: {(count / maxCount).toFixed(2)}</p>
      {/* @tag, @string, @string.regex: Hiển thị regex */}
      <p>Regex: {"/[a-z]+/"}</p>
      {/* @tag, @tag.attribute, @function.call: Input với debounce */}
      <input
        type="text"
        value={searchTerm}
        onChange={(e) => handleSearch(e.target.value)}
      />
    </div>
  );
}

// @keyword, @type.definition: Định nghĩa type với infer
type InferType<T> = T extends infer R ? R : never; // @keyword.extends, @type.builtin

// @keyword, @variable: Khai báo biến với assertion
const assertedVar = "test" as const; // @keyword.as, @string

// @error: Dòng lỗi cú pháp
const errorVar: number = "string"; // @type.builtin, @string

// @keyword.delete, @variable: Xóa thuộc tính (trong object)
const obj = { key: "value" } as any; // @keyword.as, @string
delete obj.key; // @keyword.delete

// @keyword.typeof, @variable: Kiểm tra kiểu
const typeCheck: string = typeof count; // @type.builtin

// @keyword.instanceof, @variable: Kiểm tra instance
const isError: boolean = errorVar instanceof Error; // @type.builtin, @constructor

// @keyword.in, @variable: Kiểm tra thuộc tính
const hasKey: boolean = "key" in obj; // @type.builtin, @string

// @keyword.new, @constructor: Tạo instance mới
const newInstance = new Date(); // @type.builtin

// @keyword.this, @variable.builtin: Sử dụng this trong hàm
function useThis(this: User) {
  console
  console.log(this.name); // @property
}

// @keyword.yield, @function: Hàm generator
function* generator(): Generator<number> {
  yield 1; // @keyword.yield, @number
  yield 2;
}
