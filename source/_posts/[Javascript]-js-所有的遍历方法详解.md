---
title: 所有遍历方法详解
date: '2018/8/18 21:57:28'
categories:
  - ② Javascript-ES6-Typescript
  - Javascript
updated:
tags:
comments:
---

## 一、前言

所有的遍历方法的详解。

## 二、数组/字符串--所有的遍历方法

### 2.1 for 循环遍历

```BASH
# 最简单的遍历,可以遍历字符串,变量是索引值
```

```JS
let arr = [1, 2, 3, 4, 5]
let n = arr.length
for (let i = 0; i < n; i++) {
    arr[i] = arr[i] * 10
}
console.log(arr);//[ 10, 20, 30, 40, 50 ]

//遍历字符串
let str = 'xiaomi'
let n = str.length
for (let i = 0; i < n; i++) {
    console.log(str[i]);
    // x  
    // i  
    // a  
    // o  
    // m  
    // i  
}
```

### 2.2 for....in 遍历(不推荐用在数组)

```bash
# 枚举遍历，变量是索引值
# 缺点：只能获得对象的键名，不能直接获取键值。

# for-in 循环实际是为循环 ”enumerable“ 对象而设计的，
# for in 也可以循环数组，但是不推荐这样使用，for–in 是用来循环带有字符串 key 的对象的方法。看第 三 章
```

```js
let arr = [1, 2, 3, 4, 5]
for (let i in arr) {
    console.log(`${i}:${arr[i]}`)
    // 0:1
    // 1:2
    // 2:3
    // 3:4
    // 4:5
}
```

### 2.3 for....of 遍历

```bash
# 可以中途停止遍历,可以遍历字符串，变量是索引，值 都可以的

# for of 为 ES6 提供，具有 iterator 接口，就可以用 for of 循环遍历它的成员。
# 也就是说，for of 循环内部调用的是数据结构的 Symbol.iterator 方法。
# for of 循环可以使用的范围包括数组、Set 和 Map 结构、某些类似数组的对象（比如 arguments 对象、DOM NodeList 对象）、后文的 Generator 对象，以及字符串。
# 有些数据结构是在现有数据结构的基础上，计算生成的。比如，ES6 的数组、Set、Map 都部署了以下三个方法，调用后都返回遍历器对象。
```

```JS
let arr = [1, 2, 3, 4, 5]
for (let val of arr) {
    if (val == 3) {
        break;
    } else {
        console.log(val);
        //1, 2
    }
}
for (let value of Object.values(arr)) {
    console.log(value)
    // 1
    // 2
    // 3
    // 4
    // 5
}
for (let key of Object.keys(arr)) {
    console.log(key)
    // 0
    // 1
    // 2
    // 3
    // 4
}
for (let [key, value] of Object.entries(arr)) {
    console.log(`${key}:${value}`)
    // 0:1
    // 1:2
    // 2:3
    // 3:4
    // 4:5
}
```

```JS
//遍历字符串，
let str = 'xiaomi'
for (let s of str) {
    console.log(s);
    // x
    // i
    // a
    // o
    // m
    // i
}
```

### 2.4 forEach 遍历

```BASH
# 只能遍历数组
# 不可中途停止遍历
# 没有返回值，遍历每项
# 原数组会被改变，如果对第 3 参数操作就会被改变的吧
# 优点：代码简介。
# 缺点：无法使用 break，return 等终止循环。
```

```JS
let arr = [1, 2, 3, 4, 5]
let res = arr.forEach((val, index, arr) => {
    // val 为数组的每项
    // index 索引  不需要的话就不写
    // arr 为原始数组，不需要就不写
    //数组中有几项，那么传递进去的匿名回调函数就需要执行几次
    arr[index] = val * 10
})
console.log(arr);//[ 10, 20, 30, 40, 50 ]，原数组会被改变
console.log(res);//undefined，因为没有返回值
```

```JS
let arr = [1, 2, 3, 4, 5]
arr.forEach((val) => {
  if (val == 3) {
    return false;
  } else{
    console.log(val);
    //1, 2, 3, 4, 5 即使我们使用了条件，但是 forEach 不能停止下来，还是继续的输出
  }
})
```

### 2.5 map 遍历

```BASH
# 只能遍历数组
# 遍历每项
# 有返回值！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！ 所有 v=>{ return v.xxxxxmsns 乱变}
# 原数组不会被改变(如果对第三个参数-原始数组进行操作就可能会改变了)
```

```JS
let arr = [1, 2, 3, 4, 5]
let res = arr.map((val, index, arr) => {
    return val * 10
    // val 每项的值
    // index 索引
    // arr 原始数组
    // arr[index] = arr[index] * 10 当然如果我么对第三个参数进行操作，原数组就会被改变了
})
console.log(arr); //[1, 2, 3, 4, 5]         原数组不变
console.log(res); //[ 10, 20, 30, 40, 50 ]  有返回值
```

### 2.6 filter

```BASH
# 返回一个符合条件的新数组
# 原数组不变，如果对第三个参数-原始数组进行操作，肯定会改变，arr[index] = arr[index] + 1
```

```JS
let arr = [1, 2, 3, 4, 5]
let res = arr.filter((val, index, arr) => {
    return val > 3
})
console.log(arr); //[1, 2, 3, 4, 5]         原数组不变
console.log(res); //[ 4, 5 ] 有返回值
```

### 2.7 some

```BASH
# 返回一个 boolean，判断是否有元素符合条件的值，如果有一个元素符合条件的值，则循环会终止。
```

```JS
let arr = [1, 2, 3, 4, 5]
let res = arr.some((val, index, arr) => {
    arr[index] = arr[index] + 1//[ 2, 3, 4, 5, 5 ]
    return val > 3
})
console.log(arr); //[ 2, 3, 4, 5, 5 ] 前面的项执行了操作，后面被 return 了无法执行
console.log(res); // true
```

### 2.8 every

```BASH
# 返回一个 boolean，判断是否 所有 元素符合条件的值，如果 所有 元素符合条件的值，返回 true 否则返回 false
```

```JS
let arr = [1, 2, 3, 4, 5]
let res = arr.every((val, index, arr) => {
    arr[index] = arr[index] + 1//[ 2, 3, 4, 5, 5 ]
    return val > 3
})
console.log(arr); //[ 2, 2, 3, 4, 5 ] 前面的项执行了操作，后面被 return 了无法执行
console.log(res); // false
```

## 三、对象--的所有遍历方法

### 3.1 for...in

```BASH
# 枚举遍历，变量是 key 值
```

```JS
let obj = {
    name:'xiaomi',
    age:18,
    sex:'female',
    hobby:['math','shopping','singing']
}
for (let key in obj) {
    console.log(`${key}:${obj[key]}`)
    // name:xiaomi
    // age:18
    // sex:female
    // hobby:math,shopping,singing
}
```

### 3.2 for...of

```BASH
```

```JS
let obj = {
    name: 'xiaomi',
    age: 18,
    sex: 'female',
    hobby: ['math', 'shopping', 'singing']
}
for (let value of Object.values(obj)) {
    console.log(value)
    // xiaomi
    // 18
    // female
    // [ 'math', 'shopping', 'singing' ]
}
for (let key of Object.keys(obj)) {
    console.log(key)
    // name
    // age
    // sex
    // hobby  
}
for (let [key, value] of Object.entries(obj)) {
    console.log(`${key}:${value}`)
    // name:xiaomi
    // age:18
    // sex:female
    // hobby:math,shopping,singing
}
```

## 四、set/map--的遍历方法

### 4.1 for...of    遍历 map

```JS
//任何部署了 Iterator 接口的对象，都可以用 for...of 循环遍历。Map 结构原生支持 Iterator 接口，配合变量的解构赋值，获取键名和键值就非常方便。

var map = new Map();
map.set('first', 'hello');
map.set('second', 'world');

for (let [key, value] of map) {
  console.log(key + " is " + value);
}
// first is hello
// second is world


// 获取键名
for (let [key] of map) {
  // ...
}

// 获取键值
for (let [,value] of map) {
  // ...
}
```

```js
const map = new Map([
  ['F', 'no'],
  ['T',  'yes'],
]);

for (let key of map.keys()) {
  console.log(key);
}
// "F"
// "T"

for (let value of map.values()) {
  console.log(value);
}
// "no"
// "yes"

for (let item of map.entries()) {
  console.log(item[0], item[1]);
}
// "F" "no"
// "T" "yes"

// 或者
for (let [key, value] of map.entries()) {
  console.log(key, value);
}
// "F" "no"
// "T" "yes"

// 等同于使用map.entries()
for (let [key, value] of map) {
  console.log(key, value);
}
// "F" "no"
// "T" "yes"
```

### 4.1 for...of    遍历 set

```JS
const s = new Set([1, 2, 3, 4, 4]);
for (let value of s) {
  console.log(value);
}
```

```JS
let set = new Set(['red', 'green', 'blue']);

for (let item of set.keys()) {
  console.log(item);
}
// red
// green
// blue

for (let item of set.values()) {
  console.log(item);
}
// red
// green
// blue

for (let item of set.entries()) {
  console.log(item);
}
// ["red", "red"]
// ["green", "green"]
// ["blue", "blue"]
```

### 4.1 forEach    遍历 set