---
title: 'JavaScript -- [深拷贝与浅拷贝]'
date: '2018/8/19 23:57:28'
categories:
  - 二、Javascript-ES6-Typescript
  - Javascript
abbrlink: e9e1d815
updated:
tags:
comments:
---
## 一、前言

浅拷贝 引用拷贝，两者是相互影响的。     B 修改会影响 A 的值，反之亦然
深拷贝 值的拷贝，拷贝前后的对象没有影响。B 的修改不会影响 A ，反之亦然


有个问题就是，别人都说的是 简单数组，的拷贝不属于深拷贝，[链接本文评论区](https://blog.csdn.net/FungLeo/article/details/54931379#commentsedit)


## 二、深拷贝 与 浅拷贝的

1.浅拷贝： 将原对象或原数组的引用直接赋给新对象，新数组，新对象／数组只是原对象的一个引用
2.深拷贝： 创建一个新的对象和数组，将原对象的各项属性的“值”（数组的所有元素）拷贝过来，是“值”而不是“引用”

**在 JS 这门语言中， array 也是对象，因为数组的拷贝也有深浅拷贝之说。**

### 2.1 为什么要使用深拷贝？

我们希望在改变新的 数组（对象）的时候，不改变原数组（对象）

### 2.2 深拷贝的要求程度？

我们在使用深拷贝的时候，一定要弄清楚我们对深拷贝的要求程度：
是仅 深拷贝 **第一层级**的 对象属性 或 数组元素，还是 递归拷贝 **所有层级**的 对象属性 和 数组元素 ？

### 2.3 怎么检验深拷贝成功？

改变任意一个新对象/数组中的属性/元素, 都不改变原对象/数组

## 三、数组拷贝

### 3.1 简单数组['',6，true]，直接遍历

深拷贝数组（只拷贝第一级数组元素)

#### 3.1.1 for 循环遍历

```JS
var array = [1, 2, 3, 4];
function copy (array) {
   let newArray = []
   for(let item of array) {
      newArray.push(item);
   }
   return  newArray;
}
var copyArray = copy(array);
copyArray[0] = 100;
console.log(array); // [1, 2, 3, 4]
console.log(copyArray); // [100, 2, 3, 4]
```

#### 3.1.2 slice()

```JS
var array = [1, 2, 3, 4];
var copyArray = array.slice();
copyArray[0] = 100;
console.log(array); // [1, 2, 3, 4]
console.log(copyArray); // [100, 2, 3, 4]
```

slice() 方法返回一个从已有的数组中截取一部分元素片段组成的新数组（不改变原来的数组！）
用法：array．slice(start,end)　start 表示是起始元素的下标，　end 表示的是终止元素的下标

当slice()不带任何参数的时候，默认返回一个长度和原数组相同的新数组

#### 3.1.3 concat()

```JS
var array = [1, 2, 3, 4];
var copyArray = array.concat();
copyArray[0] = 100;
console.log(array); // [1, 2, 3, 4]
console.log(copyArray); // [100, 2, 3, 4]
```

concat() 方法用于连接两个或多个数组。( 该方法不会改变现有的数组，而仅仅会返回被连接数组的一个副本。)

用法：array.concat(array1,array2,......,arrayN)

因为我们上面调用concat的时候没有带上参数，所以 var copyArray = array.concat(); 实际上相当于 var copyArray = array.concat([]);
也即把返回数组和一个空数组合并后返回

### 3.2 对象数组[{}] JSON.parse(JSON.stringify(obj1)

在 JS 中 数组也是对象，因此可以使用这个办法对于对象数字的深拷贝

```JS
//deep Clone
let obj = [{a:1,b:2}];
let obj2 = JSON.parse(JSON.stringify(obj));
obj.a = 4;
console.log(JSON.stringify(obj)); // [{a:4,b:2}]
console.log(JSON.stringify(obj2)); // [{a:1,b:2}]
```

将该对象转换为其 JSON 字符串表示形式，然后将其解析回对象。
`JSON.stringify(obj1)` 将 obj1 转化为 JSON 数据，再用 `JSON.parse` 将 JSON 数据转化为 对象。

**缺点**

- 创建了一个临时的、可能很大的字符串，只是为了把它重新放回解析器。
- 这种方法不能处理循环对象,抛出错误。
- 诸如 Map, Set, RegExp, Date, ArrayBuffer 和其他内置类型在进行序列化时会丢失。

## 四、对象 Object 实现深拷贝

对于一些时候，我们希望得到一个拷贝对象，但是希望二者不要相互影响，那么就会希望是深拷贝。

### 4.1 简单对象{}

#### 4.1.1 for 循环遍历

```JS
var obj = {
  name: 'liuxmoo',
  job: '学生'
}

function copy (obj) {
   let newObj = {};
     for (let item in obj ){
       newObj[item] = obj
     }
     return newObj;
}

var copyObj = copy(obj);
copyObj.name = 'xiaomi';
console.log(obj); // {name: "liuxmoo", job: "学生"}
console.log(copyObj); // {name: "xiaomi", job: Object}
```

#### 4.1.2 ES6 的 Object.assign 或者 Array.from

```JS
var obj = {
  name: 'liuxmoo',
  job: '学生'
}
var copyObj = Object.assign({}, obj);
copyObj.name = 'xiaomi';
console.log(obj); // {name: "liuxmoo", job: "学生"}
console.log(copyObj); // {name: "xiaomi", job: Object}
```

Object.assign：用于对象的合并，将源对象（source）的所有可枚举属性，复制到目标对象（target），并返回合并后的target

用法： Object.assign(target, source1, source2);  所以 copyObj = Object.assign({}, obj);  这段代码将会把obj中的一级属性都拷贝到 ｛｝中，然后将其返回赋给copyObj

#### 4.1.3 ES6 扩展运算符： ...

```JS
var obj = {
  name: 'liuxmoo',
  job: '学生'
}
var copyObj = { ...obj }
copyObj.name = 'xiaomi';
console.log(obj); // {name: "liuxmoo", job: "学生"}
console.log(copyObj); // {name: "xiaomi", job: Object}
```

扩展运算符（...）用于取出参数对象的所有可遍历属性，拷贝到当前对象之中

### 4.2 多层级对象 用多层花括号

### 4.2.1  obj2 = JSON.parse(JSON.stringify(obj1)) 方法 【拷贝所有层级-处理多层级对象】

```JS
//deep Clone
let obj1 = {a: 0, b: {c: 0}};
let obj3 = JSON.parse(JSON.stringify(obj1));
obj1.a = 4;
obj1.b.c = 4;
console.log(JSON.stringify(obj3)); // {a: 0, b: {c: 0}}
```

将该对象转换为其 JSON 字符串表示形式，然后将其解析回对象。
`JSON.stringify(obj1)` 将 obj1 转化为 JSON 数据，再用 `JSON.parse` 将 JSON 数据转化为 对象。

**缺点**

- 创建了一个临时的、可能很大的字符串，只是为了把它重新放回解析器。
- 这种方法不能处理循环对象,抛出错误。
- 诸如 Map, Set, RegExp, Date, ArrayBuffer 和其他内置类型在进行序列化时会丢失。

循环对象无法使用这种办法

```JS
//构建树状数据结构，其中一个节点引用其父级，而父级又引用其子级。
const x = {};
const y = {x};
x.y = y; // Cycle: x.y.x.y.x.y.x.y.x...
const copy = JSON.parse(JSON.stringify(x)); // throws! 抛出错误
```

### 4.2.2 自行编辑 的递归方法

```JS
var array = [
   { number: 1 },
   { number: 2 },
   { number: 3 }
];
function copy (obj) {
        var newobj = obj.constructor === Array ? [] : {};
        if(typeof obj !== 'object'){
            return;
        }
        for(var i in obj){
           newobj[i] = typeof obj[i] === 'object' ?
           copy(obj[i]) : obj[i];
        }
        return newobj
}
var copyArray = copy(array)
copyArray[0].number = 100;
console.log(array); //  [{number: 1}, { number: 2 }, { number: 3 }]
console.log(copyArray); // [{number: 100}, { number: 2 }, { number: 3 }]
```

### 4.5 Structured Clone 结构化克隆算法 方法

#### 4.2.1 MessageChannel

调用 postMessage 结构化克隆算法就可以使用。我们可以创建一个 MessageChannel 并发送消息。在接收端，消息包含我们原始数据对象的结构化克隆。

```JS
function structuralClone(obj) {
  return new Promise(resolve => {
    const {port1, port2} = new MessageChannel();
    port2.onmessage = ev => resolve(ev.data);
    port1.postMessage(obj);
  });
}

const obj = /* ... */;
const clone = await structuralClone(obj);
```

**缺点**
它是异步的。虽然这并无大碍，但是有时候你需要使用同步的方式来深度拷贝一个对象。

#### 4.2.2 History API

```JS
function structuralClone(obj) {
  const oldState = history.state;
  history.replaceState(obj, document.title);
  const copy = history.state;
  history.replaceState(oldState, document.title);
  return copy;
}

const obj = /* ... */;
const clone = structuralClone(obj); 
```

使用 history.pushState()写过 SPA，我们可以提供一个状态对象来保存 URL。

事实证明，这个状态对象使用结构化克隆 - 而且是同步的。我们必须小心使用，不要把程序逻辑使用的状态对象搞乱了，所以我们需要在完成克隆之后恢复原始状态。为了防止发生任何意外，请使用 history.replaceState() 而不是 history.pushState()。

**缺点**

- 然而，仅仅为了复制一个对象，而使用浏览器的引擎，感觉有点过分。
- Safari 浏览器对 replaceState 调用的限制数量为 30 秒内 100 次。

#### 4.2.3 Notification API

```JS
function structuralClone(obj) {
  return new Notification('', {data: obj, silent: true}).data;
}

const obj = /* ... */;
const clone = structuralClone(obj);
```

短小，简洁。

**缺点** 需要浏览器内部的权限机制，所以它是可能是很慢的？？？？？。由于某种原因，Safari 总是返回undefined。

## 七、性能

深拷贝实际上是很消耗性能的。
（我们可能只是希望改变新数组里的其中一个元素的时候不影响原数组，但却被迫要把整个原数组都拷贝一遍，这不是一种浪费吗？）

所以，当你的项目里有大量深拷贝需求的时候，性能就可能形成了一个制约的瓶颈了。

### 7.1 存在大量深拷贝需求的代码——immutable提供的解决方案

通过immutable引入的一套API，实现：

1.在改变新的数组（对象）的时候，不改变原数组（对象）
2.在大量深拷贝操作中显著地减少性能消耗

```JS
const { Map } = require('immutable')
const map1 = Map({ a: 1, b: 2, c: 3 })
const map2 = map1.set('b', 50)
map1.get('b') // 2
map2.get('b') // 50
```