---
title: 'TypeScript--[入门'
date: '2018/8/19 23:57:28'
tags:
  - 递归函数
categories:
  - ② Javascript-ES6-Typescript
  - TypeScript
abbrlink: 4f7de2e4
updated:
comments:
---
# 一、前言

TypeScript 是 JavaScript 的一个超集，主要提供了类型系统和对 ES6 的支持，它由 Microsoft 开发，代码开源于 GitHub 上。TypeScript 是 JavaScript 的类型的超集，它可以编译成纯 JavaScript。编译出来的 JavaScript 可以运行在任何浏览器上。TypeScript 编译工具可以运行在任何服务器和任何系统上。TypeScript 是开源的。

[英文文档](http://www.typescriptlang.org/docs/handbook/basic-types.html)
[中文文档](https://www.tslang.cn/docs/home.html)
[阮一峰教程](https://ts.xcatliu.com/)

typescript 的简称是 TS, 下文将以 TS 称之。

# 二、TS 特点

- 增加了代码的可读性和可维护性
    **类型系统**实际上是最好的文档，大部分的函数看看 类型的定义 就可以知道如何使用了
    可以在编译阶段就 **发现大部分错误**，这总比在运行时候出错好
    增强了 **编辑器和 IDE 的功能**，包括代码补全、接口提示、跳转到定义、重构等
- 非常包容
    TypeScript 是 JavaScript 的超集，.js 文件可以直接重命名为 .ts 即可
    即使不显式的定义类型，也能够自动做出类型推论
    可以定义从简单到复杂的几乎一切类型
    即使 TypeScript 编译报错，也可以生成 JavaScript 文件
    兼容第三方库，即使第三方库不是用 TypeScript 写的，也可以编写单独的类型文件供 TypeScript 读取
- TypeScript 拥有活跃的社区
    大部分第三方库都有提供给 TypeScript 的类型定义文件
    Google 开发的 Angular2 就是使用 TypeScript 编写的
    TypeScript 拥抱了 ES6 规范，也支持部分 ESNext 草案的规范
- TypeScript 的缺点
    有一定的学习成本，需要理解接口（Interfaces）、泛型（Generics）、类（Classes）、枚举类型（Enums）等前端工程师可能不是很熟悉的概念
    短期可能会增加一些开发成本，毕竟要多写一些类型的定义，不过对于一个需要长期维护的项目，TypeScript 能够减少其维护成本
    集成到构建流程需要一些工作量
    可能和一些库结合的不是很完美
  
根据自己团队和项目的情况判断是否需要使用 TypeScript。

# 三、安装 TypeScript

```BASH
# npm 安装
$ npm install -g typescript
# 会在全局环境下安装 tsc 命令，安装完成之后，我们就可以在任何地方执行 tsc 命令了
```

# 四、理解 TypeScript

**.ts** 我们约定使用 TypeScript 编写的文件以 .ts 为后缀，
**.tsx**TypeScript 编写 React 时，以 .tsx 为后缀！！！！react 中是 xxx.tsx 文件

TypeScript 是 JavaScript 的一个超集，是需要编辑器的支持，我们才能在编辑器编辑 ts 类型的文件。因为它是微软的，所以编辑器 Visual Studio Code 也是微软的，17 版的 vscode 内置了 TypeScript。其他的编辑器根据自己的需求去获取 TypeScript 支持。

## 4.1 TypeScript 文件最终还是编译为 js 文件

```TS
// 创建 greeter.ts 文件
function greeter(person: string) {
    return "Hello, " + person;
}

let user = "Jane User";

document.body.innerHTML = greeter(user);
```

```BASH
# 使用 tsc 命令来编译 ts 文件
$ tsc greeter.ts
# 在当前目录文件夹下，将产生一个 greeter.js 文件
```

## 4.2 类型注解 定义的变量，传入的参数，函数返回值的，类型

: 冒号前候有无空格均可（但是貌似后面给个空格会比较好看把，习惯）

**说白了，类型注解就是让我们方便知道定义的变量，传入的参数，函数返回值的，类型。让编译器帮助我们判断对错。**

TypeScript 里的类型注解是一种轻量级的为**函数** 或 **变量** 添加约束的方式。 冒号前候有无空格都行。

```TS
function greeter(person: string) {// 我们希望传进来的参数 person 是字符串，如果不是字符串将会报错
    return "Hello, " + person;
}

let user = [0, 1, 2];

document.body.innerHTML = greeter(user);
```

```BASH
greeter.ts(7,26): error TS2345: Argument of type 'number[]' is not assignable to parameter of type 'string'.
```

### 4.2.1 类型不对，但是依然会被编译

上面的 ts 文件，虽然穿进去的参数类型是不对的，但是它依然会编译得到一个 js 文件。只是会在编译的时候命令行报错。

### 4.2.2 避免类型错误依然编译问题

如果要在报错的时候终止 js 文件的生成，可以在 tsconfig.json 中配置 noEmitOnError 即可。这个知识点看文章后续。

## 4.3 类型断言（）

有时候你会遇到这样的情况，你会比 TypeScript 更了解某个值的详细信息。 通常这会发生在你清楚地知道一个实体具有比它现有类型更确切的类型。**说白了，就是说我们知道这个值是什么类型的，我们直接告诉编译器**。通过类型断言这种方式可以告诉编译器，“相信我，我知道自己在干什么”。 类型断言好比其它语言里的类型转换，但是不进行特殊的数据检查和解构。 它没有运行时的影响，只是在编译阶段起作用。 TypeScript 会假设你，程序员，已经进行了必须的检查。

2 中办发来做类型断言，两种形式是等价的。 至于使用哪个大多数情况下是凭个人喜好；
然而，当你在 TypeScript 里使用 **JSX 时，只有 as 语法断言是被允许的。**

### 4.3.1 类型断言 尖括号 语法

```TS
let someValue: any = "this is a string";
let strLength: number = (<string>someValue).length;
```

### 4.3.2 类型断言 as 语法

```TS
let someValue: any = "this is a string";
let strLength: number = (someValue as string).length;
```

## 4.4 类型推论 没有定义类型，编译器会根据赋值来推断类型

TypeScript 会在没有明确的指定类型的时候推测出一个类型，这就是类型推论。

```TS
//以下代码虽然没有指定类型，但是会在编译的时候报错：
let myFavoriteNumber = 'seven';// 第一次赋值是一个字符串，后面就不能赋值为其他的类型了。
//除非是后面的给了一个类型是 any 那就随你去修改变量的类型。
myFavoriteNumber = 7;// index.ts(2,1): error TS2322: Type 'number' is not assignable to type 'string'.
// 它等价于
let myFavoriteNumber: string = 'seven';
myFavoriteNumber = 7;// index.ts(2,1): error TS2322: Type 'number' is not assignable to type 'string'.
```

# 五、ts 基础学习

JavaScript 的类型分为两种：**原始数据类型**（Primitive data types）和**对象类型**（Object types）。

**原始数据类型包括**：布尔值、数值、字符串、null、undefined 以及 ES6 中的新类型 Symbol。

一样的，ts 只是 js 的超级，它跟 js 一样的。

## 5.1 基础类型

### 5.1.1 布尔值类型

在 TypeScript 中，boolean 是 JavaScript 中的基本类型，
而 JavaScript 中，Boolean 是 JavaScript 中的构造函数。
其他基本类型（除了 null 和 undefined）一样，不再赘述。

```TS
let isDone: boolean = false;//变量注解   布尔值类型

let createdByNewBoolean: boolean = new Boolean(1);//error
// index.ts(1,5): error TS2322: Type 'Boolean' is not assignable to type 'boolean'.
// 使用构造函数 Boolean 创造的对象不是布尔值

//事实上 new Boolean() 返回的是一个 Boolean 对象：
let createdByNewBoolean: Boolean = new Boolean(1);//ok
//直接调用 Boolean 也可以返回一个 boolean 类型：
let createdByBoolean: boolean = Boolean(1);//ok
```

### 5.1.2 数值类型

```TS
let decLiteral: number = 6;//变量注解   数值类型
let hexLiteral: number = 0xf00d;// ES6 中的二进制表示法
let binaryLiteral: number = 0b1010;//十 进制
let octalLiteral: number = 0o744;// ES6 中的八进制表示法
let notANumber: number = NaN;
let infinityNumber: number = Infinity;
```

```JS
//编译后
var decLiteral = 6;
var hexLiteral = 0xf00d;
var binaryLiteral = 10;// ES6 中的二进制表示法
var octalLiteral = 484;// ES6 中的八进制表示法
var notANumber = NaN;
var infinityNumber = Infinity;

//0b1010 和 0o744 是 ES6 中的二进制和八进制表示法，它们会被编译为十进制数字。
```

### 5.1.3 字符串类型

```TS
let name: string = "bob";//变量注解   字符串类型，单双引号都可以，还有字符串模板 `` 都可以的
name = "smith";

let name: string = `Gene`;
let age: number = 37;
let sentence: string = `Hello, my name is ${ name }.


I'll be ${ age + 1 } years old next month.`;//等价于，注意到上面是两个换行，下面这里字符串拼接就是 \n\n
let sentence: string = "Hello, my name is " + name + ".\n\n" + "I'll be " + (age + 1) + " years old next month.";
```

### 5.1.4 数组类型

#### 5.1.4.1 普通数组

```TS
let list: number[] = [1, 2, 3];
let list: Array<number> = [1, 2, 3];
```

#### 5.1.4.5 元组 就是元素类型不同/多元化 的 数组

```TS
let x: [string, number];   // 定义一个元组类型
x = ['hello', 10]; // 给它初始化，成功能
x = [10, 'hello']; // 初始化不成功，VScode 编辑器会把有错误的数据标明红色底纹!!!!!!!!!!!!!!!特别好!!!!!!!!!!!!!!!!!!!!
console.log(x[0].substr(1)); // OK
console.log(x[1].substr(1)); // Error, 'number' does not have 'substr'
//当访问一个越界的元素，会使用联合类型替代：只能是联合定义的时候给的类型，其他的类型不可以。
x[3] = 'world'; // OK, 字符串可以赋值给(string | number)类型
console.log(x[5].toString()); // OK, 'string' 和 'number' 都有 toString
x[6] = true; // Error, 布尔不是(string | number)类型
```

#### 5.1.4.6 枚举 enum

enum 类型是对 JavaScript 标准数据类型的一个补充。 像 C# 等其它语言一样，使用 枚举类型 可以为 一组数值 赋予友好的名字。

```TS
enum Color {Red, Green, Blue}
let c: Color = Color.Green;

//默认情况下，从 0 开始为元素编号。 你也可以手动的指定成员的数值。 例如，我们将上面的例子改成从 1开始编号：
enum Color {Red = 1, Green, Blue}
let c: Color = Color.Green;

//全部都采用手动赋值
enum Color {Red = 1, Green = 2, Blue = 4}
let c: Color = Color.Green;

//枚举类型提供的一个便利是你可以由枚举的值得到它的名字。
//例如，我们知道数值为 2 ，但是不确定它映射到 Color 里的哪个名字，我们可以查找相应的名字：
enum Color {Red = 1, Green, Blue}
let colorName: string = Color[2];
console.log(colorName);  // 显示'Green'因为上面代码里它的值是2
```

### 5.1.5 Any 任意不指定类型

有时候，我们会想要为那些在编程阶段还不清楚类型的变量指定一个类型。 这些值可能来自于动态的内容，比如来自用户输入或第三方代码库。 这种情况下，我们不希望类型检查器对这些值进行检查而是直接让它们通过编译阶段的检查。 那么我们可以使用 any 类型来标记这些变量：

```TS
let notSure: any = 4;
notSure = "maybe a string instead";
notSure = false; // ok, definitely a boolean
```

在对现有代码进行改写的时候，any 类型是十分有用的，它允许你在编译时可选择地包含或移除类型检查。 你可能认为 Object 有相似的作用，就像它在其它语言中那样。 但是 Object 类型的变量只是允许你给它赋任意值 - 但是却不能够在它上面调用任意的方法，即便它真的有这些方法：

```TS
let notSure: any = 4;
notSure.ifItExists(); // ok, ifItExists might exist at runtime
notSure.toFixed(); // ok, toFixed exists (but the compiler doesn't check)

let prettySure: Object = 4;
prettySure.toFixed(); // Error: Property 'toFixed' doesn't exist on type 'Object'.
```

```TS
//你只知道一部分数据的类型时，any 类型也是有用的。 比如，你有一个数组，它包含了不同的类型的数据：
let list: any[] = [1, true, "free"];
list[1] = 100;
```

```TS
//如果是一个普通类型，在赋值过程中改变类型是不被允许的：
let myFavoriteNumber: string = 'seven';
myFavoriteNumber = 7;// index.ts(2,1): error TS2322: Type 'number' is not assignable to type 'string'.

let myFavoriteNumber: any = 'seven';
myFavoriteNumber = 7;//ok
```

```TS
//在任意值上访问任何属性都是允许的：
let anyThing: any = 'hello';
console.log(anyThing.myName);
console.log(anyThing.myName.firstName);
//也允许调用任何方法：
let anyThing: any = 'Tom';
anyThing.setName('Jerry');
anyThing.setName('Jerry').sayHello();
anyThing.myName.setFirstName('Cat');
//可以认为，声明一个变量为任意值之后，对它的任何操作，返回的内容的类型都是任意值。
```

```TS
// 未声明类型的变量
// 变量如果在声明的时候，未指定其类型，那么它会被识别为任意值类型：

let something;
something = 'seven';
something = 7;
something.setName('Tom');
//等价于
let something: any;
something = 'seven';
something = 7;
something.setName('Tom');
```

### 5.1.6 空值 void 像是与any类型相反,表示没有任何类型

JavaScript 没有空值（Void）的概念，在 TypeScript 中，可以用 void 表示没有任何返回值的函数：

```TS
function alertName(): void {
    alert('My name is Tom');
}
```

```TS
let unusable: void = undefined;
// 虽然没有错误，但是声明一个 void 类型的变量没有什么用，因为你只能将它赋值为 undefined 和 null
```

### 5.1.7 Null 和 Undefined

```TS
//在 TypeScript 中，可以使用 null 和 undefined 来定义这两个原始数据类型：
//undefined 类型的变量只能被赋值为 undefined，null 类型的变量只能被赋值为 null。
let u: undefined = undefined;
let n: null = null;
```

```TS
//与 void 的区别是，undefined 和 null 是所有类型的子类型。也就是说 undefined 类型的变量，可以赋值给 number 类型的变量：
// 非严格模式
let num: number = undefined;// 这样不会报错，但是严格模式来说就错误了，而且也推荐使用严格模式
let u: undefined;// 这样也不会报错，但是严格模式来说就错误了，而且也推荐使用严格模式
let num: number = u;// 这样也不会报错，但是严格模式来说就错误了，而且也推荐使用严格模式

//在严格模式来说，上面这样写是错误的。
//null和undefined只能赋值给void和它们各自。 这能避免 很多常见的问题。
//也许在某处你想传入一个 string 或 null 或 undefined，你可以使用联合类型 string | null | undefined

let u: void;
let num: number = u;// error，   void 类型的变量不能赋值给 number 类型的变量：
// index.ts(2,5): error TS2322: Type 'void' is not assignable to type 'number'.
```

### 5.1.8 Never 那些永不存在的值的类型

never 类型是那些 **总是会抛出异常**或 **根本就不会有返回值的函数表达式**或 **箭头函数表达式的返回值类型**; 变量也可能是 never 类型，当它们被永不为真的类型保护所约束时。

never 类型是任何类型的子类型，也可以赋值给任何类型；
然而，没有类型是 never 的子类型或可以赋值给 never 类型（除了 never 本身之外）。 即使 any 也不可以赋值给 never。

```TS
// 返回never的函数必须存在无法达到的终点
function error(message: string): never {
    throw new Error(message);
}

// 推断的返回值类型为never
function fail() {
    return error("Something failed");
}

// 返回never的函数必须存在无法达到的终点
function infiniteLoop(): never {
    while (true) {
    }
}
```

### 5.1.9 Object 非原始类型

object 表示非原始类型，也就是除 number，string，boolean，symbol，null 或 undefined 之外的类型。使用 object 类型，就可以更好的表示像 Object.create 这样的 API

```TS
declare function create(o: object | null): void;// 参数类型为 对象 或者 null ，没有返回值

create({ prop: 0 }); // OK
create(null); // OK

create(42); // Error
create("string"); // Error
create(false); // Error
create(undefined); // Error
```