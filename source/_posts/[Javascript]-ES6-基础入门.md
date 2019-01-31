---
title: 'ES6【1】--[ECMAScript 6 入门]'
date: '2018/8/19 23:57:28'
categories:
  - ② Javascript-ES6-Typescript
  - ES6
updated:
tags:
comments:
---
## 一、前言

全面介绍 ECMAScript 6 新引入的语法特性。

ECMAScript 6.0（以下简称 ES6）是 JavaScript 语言的下一代标准，已经在 2015 年 6 月正式发布了。它的目标，是使得 JavaScript 语言可以用来编写复杂的大型应用程序，成为企业级开发语言。

阮一峰的教程说的太多了，太细，不适合入门，入门就看这篇文章就好了。

## 二、var let const

```JS
// for 中使用 let 来声明是极好的
for(let i=0;i<n;i++){
  //
}

// 块级作用域
```

## 三、解构赋值

解构赋值在实际开发中可以大量减少我们的代码量，并且让我们的程序结构更清晰。

### 3.1 数组解构赋值

```JS
// 数组解构赋值---顺序赋值
let  [a,b,c] = [1,2,3];//得到 a=1    b=2   c=3
let  [a,[b,c],d] = [1,[2,3],4];//得到 a=1    b=2   c=3  d=4
let  [a,,c] = [1,2,3];//得到 a=1  c=3
let  [a,b] = [1];//得到 a=1  b=undefined
let  [a,b=1] = [1,undefined];//得到 a=1  b=1
let  [a,b=1] = [1,null];//得到 a=1  b=null

//可以用值交换,交换变量的值
let x = 1;
let y = 2;
[x, y] = [y, x];


//从函数返回多个值，函数只能返回一个值，如果要返回多个值，只能将它们放在数组或对象里返回。有了解构赋值，取出这些值就非常方便。
function example() {
  return [1, 2, 3];
}
let [a, b, c] = example();
```

### 3.2 对象解构赋值

```JS
//字符串解构赋值-顺序赋值（类似数组）
let {a,b,c,d} = 'xiaomi'
// a='x' b='i' c='a' d='o'

// 返回多个值， 返回一个对象，函数只能返回一个值，如果要返回多个值，只能将它们放在数组或对象里返回。有了解构赋值，取出这些值就非常方便。
function example() {
return {
 foo: 1,
 bar: 2
};
}
let { foo, bar } = example();
```

```JS
//对象的解构赋值---同名赋值
let {name,age} = {
  name: 'xiaomi',
  age: 18
}
console.log(name);//xiaomi
console.log(age);//18



// 如果先声明了变量，再解构赋值，要给语句添加括号 ()，不然会报错
let res = {
    name: 'xiaomi',//假设这里是后端给的数据
    age: 18
};
let name;//这里先声明了
let age;
({//这里解构赋值要给 ()
    name,
    age
} = res)
console.log(name); //xiaomi
console.log(age); //18
```

### 3.3 数组对象赋值

对象部分同名解构赋值，数组部分顺序赋值，
对象的解构赋值可以用很多次。

```JS
// 这样 p 不是变量，不能赋值的
let obj = {
  p: [
    'Hello',
    { y: 'World' }
  ]
};

let { p: [x, { y }] } = obj;
x // "Hello"
y // "World"
```

```JS
// 这样 p 也会被赋值！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
let obj = {
  p: [
    'Hello',
    { y: 'World' }
  ]
};

let { p, p: [x, { y }] } = obj;
x // "Hello"
y // "World"
p // ["Hello", {y: "World"}]
```

```JS
// 更加复杂的解构赋值，对象的解构赋值可以用很多次。！！！！！！！！！！！！！！！！！
const node = {
  loc: {
    start: {
      line: 1,
      column: 5
    }
  }
};

let { loc, loc: { start }, loc: { start: { line }} } = node;
line // 1
loc  // Object {start: Object}
start // Object {line: 1, column: 5}
```

```JS
// 实际应用~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//提取 JSON 数据，快速提取从后端获取来的数据
let jsonData = {
  id: 42,
  status: "OK",
  data: [867, 5309]
};

let {id,status,data:number} = jsonData;//这里 data 只是一个模量，不需要解构赋值
console.log(id, status, number);// 42, "OK", [867, 5309]
```

### 3.4 函数参数的解构赋值

```JS
function add([x, y]){
  return x + y;
}

add([1, 2]); // 3
```

```JS
function move({x = 0, y = 0} = {}) {
  return [x, y];
}

move({x: 3, y: 8}); // [3, 8]
move({x: 3}); // [3, 0]
move({}); // [0, 0]
move(); // [0, 0]
```

```JS
// 实际应用~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 指定参数的默认值，就避免了在函数体内部再写 var foo = config.foo || 'default foo'; 这样的语句。
jQuery.ajax = function (url, {
  async = true,
  beforeSend = function () {},
  cache = true,
  complete = function () {},
  crossDomain = false,
  global = true,
  // ... more config
}) {
  // ... do stuff
};
```

```JS
// 实际应用~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let json = {
  name:'xiaomi',
  age:18
}
function fun({name,age=18}){//这样传参就不需要 .属性了，简单了很多
    console.log(a,b);
}
fun(json);



let arr = ['xiaomi',18,'female'];
function fun(a,b,c){
    console.log(a,b,c);
}
fun(...arr);//拓展运算符传参也简答了
```

### 3.5 set/map 的遍历

```JS
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

### 3.6 输入模块的指定方法

```JS
const { SourceMapConsumer, SourceNode } = require("source-map");
// 导入react组件
import {ReactComponent} from './xxxComponent.jsx';
```

## 四、扩展运算符 和 rest 运算符（都是 4 个点）

### 4.1 扩展运算符

它们可以很好的为我们解决参数和对象数组未知情况下的编程，让我们的代码更健壮和简洁。

```JS
//可以给一个函数传入不同个数的参数
function AA(...arg){
  arg[0]//1
  arg[1]//2
  arg[2]//3
  arg[3]//undefined
}
AA(1,2,3);
AA('xiaomi',18);//  arg[0]=xiaomi         arg[1]=18
```

```JS
// 解决数组的引用问题（浅拷贝）
let arr = ['xiaomi', 18]
let arr1 = [...arr]
arr1.push('female');
console.log(arr); //[ 'xiaomi', 18 ]
console.log(arr1); //[ 'xiaomi', 18, 'female' ]  达到了深拷贝的效果


// 解决对象引用问题（浅拷贝）
let obj = {
    name: 'XIAOMI',
    age: 18
}
let obj1 = { ...obj
}
obj1.name = 'mei'
console.log(obj);//{ name: 'XIAOMI', age: 18 }   obj 不受 obj1 的影响了，达到了深拷贝的效果
console.log(obj1);//{ name: 'mei', age: 18 }
```

### 4.2 rest 运算符

```JS
//可以给一个函数传入不同个数的参数, 后面的是剩余参数
function AA(name, ...arg) {
    console.log(arg[0]) //18
    console.log(arg[1]) //19
    console.log(arg[2]) //undefined
}
AA('xiaomi', 18, 19);
```

## 五、字符串模版

```JS
let name = 'xiaomi'
let age = 18
let str = name + ' is ' + age + ' year old!'// ES5 字符串拼接，注意空格需要放在冒号里面，不然单词就链接在一起了
let str1 = `${name} is ${age} year old！`//    ES6 字符串模本，`` 反引号中所有的数据，包括空格都是直接的结果
console.log(str);//xiaomi is 18 year old!
console.log(str1);//xiaomi is 18 year old!
```

![TU](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190126184616.png)

```JS
// 字符串模本写 html 代码片段
let name = 'xiaomi'
let str = `<h1>标题</h1>
  <div>
    <span>${name}</span>
    <span>333</span>
  </div>`;
document.write(str);
```

```JS
//字符串模板做计算
let a=1;
let b=2;
let result=`${a+b}`;//3
```

```JS
let name = 'xiaomi'
let res = name.indexOf('ao')//2
let res1 = name.includes('ao') //true
console.log(name.startsWith('ao'))//false
console.log(name.startsWith('x'))//true
console.log(name.endsWith('i'))//true

'*'.repeat(10)// **********
```

## 六、ES6 数字操作

```JS
let binary = 0B010101;//21   二进制： 数字0 + 字母b（不区分大小写）
let o = 0o666;//438          八进制： 数字0 + 字母o（不区分大小写）
```

```JS
// 是否无线
let a= 11/4;
console.log(Number.isFinite(a));//true
console.log(Number.isFinite('jspang'));//false
console.log(Number.isFinite(NaN));//false
console.log(Number.isFinite(undefined));//false

//是否为 NaN
Number.isNaN(NaN)//true

//是否为整数
let a=123.1;
console.log(Number.isInteger(a)); //false

//整数转换
let a='9.18';
console.log(Number.parseInt(a));
console.log(Number.parseFloat(a));
```

## 十一、Symbol

### 11.1 用 Symbol 构建对象的 Key，并调用和赋值。

```JS
let s = Symbol();
let obj={
    [s]:'xiaomi'
}
console.log(obj[s]);//xiaomi
obj[s]='web';
console.log(obj[s]);//web
```

### 11.2 Symbol 对象元素的保护作用

在对象中有很多值，但是循环输出时，并不希望全部输出，那我们就可以使用 Symbol 进行保护。

```JS
let obj={name:'xiaomi',sex:'female'};
let age=Symbol();
obj[age]=18;
for (let item in obj){
    console.log(obj[item]);
    //xiaomi
    //female
}
console.log(obj);//{ name: 'xiaomi', sex: 'female', [Symbol()]: 18 }
```

## 十二、set/map  为 JS 内置的 数据结构

### 12.1 set (它类似于数组，但是成员的值都是唯一的，没有重复的值。)

```JS
let s = new Set();//声明空值

const set = new Set([1, 2, 3, 4, 4]);
console.log(set)//Set { 1, 2, 3, 4 }
```

```JS
// add(value)：   添加某个值，   返回 Set 结构本身。
// delete(value)：删除某个值，   返回一个布尔值，表示删除是否成功。
// has(value)：                 返回一个布尔值，表示该值是否为Set的成员。
// clear()：      清除所有成员， 没有返回值。
//size 属性       获取长度值
let s = new Set();
s.add('xiaomi')
console.log(a.size)//1
console.log(s)//Set { 'xiaomi' }
s.add(18)
console.log(s)//Set { 'xiaomi', 18 }

console.log(s.delete(18))//true
console.log(s)//Set { 'xiaomi' }

console.log(s.has(18))//false
console.log(s)//Set { 'xiaomi' }

s.clear()
console.log(s)//Set {}
```

```js
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

### 12.2 map

```JS
let map=new Map();//声明空值

const map = new Map([
  ['F', 'no'],
  ['T',  'yes'],
]);
```

```JS
// set(value)：   添加某个键值对，   返回 map 结构本身。
// get(value)：                 用 key 获取 value 值
// delete(value)：删除某个键值对，   返回一个布尔值，表示删除是否成功。
// has(value)：                 返回一个布尔值，表示该值是否为Set的成员。
// clear()：      清除所有成员， 没有返回值。
//size 属性       获取长度值
let m = new Map();
m.set('name', 'xiaomi') //key value
m.size //1
console.log(m); //Map { 'name' => 'xiaomi' }
m.set('age', 18)
console.log(m); //Map { 'name' => 'xiaomi', 'age' => 18 }

console.log(m.get('age')) //18  用 key 键来获取 value 值

console.log(m.delete('age')) //true
console.log(m) //Map { 'name' => 'xiaomi' }
console.log(m.has('name'))//true  用 key 键来判断

m.clear()
```

```JS
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

## 十三、new Proxy({})

本文省略

## 十五、Promise 对象

本文省略

## 二十、class 与 它的继承

```JS
class Myclass {
    constructor(x, y, c = 1) {
        //在类的参数传递中我们用constructor( )进行传参。传递参数后可以直接使用 this.xxx 进行调用。
        this.x = x;
        this.y = y;
        this.c = c;
        this.toString = this.toString.bind(this)//这样来解决 this 的指向问题最简单
    }

    // prop 属性有对应的存值函数和取值函数，因此赋值和读取行为都被自定义了。
    // 问题这个不需要绑定 this 了么？？？
    get prop() {
        return this.c = this.c * 10;
    }
    set prop(value) {
        this.c = value;
    }

    toString() {
        return '(' + this.x + ', ' + this.y + ')';
    }
}

var mm = new Myclass(2, 3);
console.log(mm.toString()) // (2, 3)
mm.prop = 5
console.log(mm.prop) //50


//类的方法内部如果含有this，它默认指向类的实例。但是，必须非常小心，一旦单独使用该方法，很可能报错。
// 就是说将它解构赋值给了别人就变成单独的了，这样来使用方法， this 的指向就会被改变了
```