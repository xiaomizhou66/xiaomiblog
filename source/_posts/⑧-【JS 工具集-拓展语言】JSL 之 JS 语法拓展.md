---
title: JXL 之 JS 语法拓展
date: '2018/8/19 23:57:28'
categories:
  - ⑧ JS 工具集/ JS拓展语言
  - JSL 拓展语言
abbrlink: 5e5bb7ff
updated:
tags:
comments:
---

# 一、什么是 JSX？

```JS
const element = <h1>Hello, world!</h1>;
```

上面这种看起来可能有些奇怪的标签语法 **既不是字符串**也 **不是 HTML**。 它是JSX，一种 JavaScript 的语法扩展。JSX 乍看起来可能比较像是模版语言，但事实上它完全是在 JavaScript 内部实现的。

React.js 以及 vue.js 这两个框架都是使用 JSX 来描述用户界面。JSX 用来声明 React.js 以及 vue.js 当中的元素。使用 render 宣传出来的。

本文学习 JSX 都是按照 react 来解说， vue.js 都是一样的。

# 二、 JSX 学习使用

## 2.1 在 JSX 中使用表达式

可以任意地在 JSX 当中使用 JavaScript 表达式，在 JSX 当中的表达式要包含在大括号里。

```JS
// 没有表达式的情况，不必加上括号，还是加上括号比较好吧！！，句子多的话也是加的就不要为难自己了。
const element = <h1>Hello, world!</h1>;
```

```JS
function formatName(user) {
  return user.firstName + ' ' + user.lastName;
}

const user = {
  firstName: 'Harper',
  lastName: 'Perez'
};
// 使用了表达式 要加上括号才行，并且要给表达式加上一对 花括号!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const element = (
  <h1>
    Hello, {formatName(user)}!
  </h1>
);
```

## 2.2 JSX 本身其实也是一种表达式

在编译之后呢，JSX 其实会被转化为普通的 JavaScript 对象。这也就意味着，你其实 **可以在 if 或者 for 语句里使用 JSX**，将它赋值给变量，当作参数传入，作为返回值都可以：

```JS
function getGreeting(user) {
  if (user) {
    return <h1>Hello, {formatName(user)}!</h1>;// 这里怎么就不加括号呢？？？？？？？？？？？？？？？？？？？？？？？？？？？？
  }
  return <h1>Hello, Stranger.</h1>;
}
```

## 2.3 JSX 属性

可以使用 **引号**来定义以 **字符串为值**的 **属性**： tabIndex="0"

```JS
const element = <div tabIndex="0"></div>;
```

也可以使用 **大括号**来定义以 **JavaScript 表达式**为值的属性： src={user.avatarUrl}

```JS
const element = <img src={user.avatarUrl}></img>;
//注意这里的 src 使用了花括号就不要在外面再使用过 引号了!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// 如果加上引号的话，JSX 会将引号当中的内容识别为 字符串 而不是 表达式。
const element = <img src={user.avatarUrl}/>; // 如果是半闭标签
```

## 2.4 JSX 嵌套

```JS
// 这里怎么又用括号了？？？多个句子的话就用括号？？？？
const element = (
  <div>
    <h1>Hello!</h1>
    <h2>Good to see you here.</h2>
  </div>
);
```

## 2.5 属性的 camelCase 小驼峰命名!!!!!!!!!!!!!!!!!!!!!!!!!!!!重点，在 vue.js 或者 react.js 都会涉及到这个问题。

因为 JSX 的特性 **更接近 JavaScript 而不是 HTML** , 所以 React DOM **使用 camelCase 小驼峰命名** 来定义属性的名称，**而不是使用 HTML 的属性名称。**

例如，class 变成了 className，而 tabindex 则对应着 tabIndex。

## 2.6 JSX 防注入攻击!!!!!!!!!!!!!!!!!!!!!!!!!!!! input 输入框就适合使用这个拓展语言来写。

```JS
const title = response.potentiallyMaliciousInput;
// 直接使用是安全的：可以放心地在 JSX 当中使用用户输入： input 输入框
const element = <h1>{title}</h1>;
```

React DOM 在渲染之前默认会 过滤 所有传入的值。它可以确保你的应用不会被注入攻击。所有的内容在渲染之前都被转换成了字符串。这样可以有效地防止 XSS(跨站脚本) 攻击.

## 2.7 JSX 代表 Objects

Babel 转译器会把 JSX 转换成一个名为 React.createElement() 的方法调用。

```JS
// JSX 写法
const element = (
  <h1 className="greeting">
    Hello, world!
  </h1>
);

// 等价于
//React.createElement() 的方法 调用的写法
const element = React.createElement(
  'h1',// 参数 1，元素，或者是函数返回，或者是组件
  {
    className: 'greeting'// 参数 2 一些属性值
  },
  'Hello, world!'// 参数3 文本/子组件/子元素
);
```

```JS
//React.createElement() 这个方法首先会进行一些避免 bug 的检查，之后会返回一个类似下面例子的对象：
// 注意: 以下示例是简化过的（不代表在 React 源码中是这样）就是说，下面的代码是用来理解的，写代码的时候不要这样写!!!!!!!!!!!!!!!!!!!
const element = {
  type: 'h1',
  props: {
    className: 'greeting',
    children: 'Hello, world'
  }
};
//这样的对象被称为 “React 元素”。它代表所有你在屏幕上看到的东西。React 通过读取这些对象来构建 DOM 并保持数据内容一致。
```

# 三、JSX 元素的渲染 ReactDOM.render()

与浏览器的 DOM 元素不同，React 当中的元素 **事实上是普通的对象**，React DOM 可以确保 浏览器 DOM 的数据内容与 React 元素保持一致。
元素是 html 原始标签/元素 ，组件是我们自定义的（虽然也是按照元素标签一样使用的，但是他们不是元素）。初学者要知道区分二者。

## 3.1 ReactDOM.render() 将元素渲染到 DOM 中

```HTML
<!-- 这个节点即将用来给 ReactDOM 天界内容，称之为  “根” DOM 节点。 React 开发应用时一般只会定义一个根节点。 -->
<div id="root"></div>
```

```JS
const element = <h1>Hello, world</h1>;
//要将 React 元素渲染到根 DOM 节点中，我们通过把它们都传递给 ReactDOM.render() 的方法来将其渲染到页面上：
ReactDOM.render(element, document.getElementById('root'));
```

## 3.2 更新元素渲染：有状态组件 实现 DOM 更新方式(在 react 中去学习。)

React 元素都是 **immutable 不可变**的。当元素被创建之后，你是无法改变其内容或属性的。一个元素就好像是动画里的一帧，它代表应用界面在某一时间点的样子。

根据我们 **现阶段了解的有关 React 知识，更新界面的唯一办法是创建一个新的元素**，然后将它传入 ReactDOM.render() 方法：

```JS
function tick() {
  const element = (
    <div>
      <h1>Hello, world!</h1>
      <h2>It is {new Date().toLocaleTimeString()}.</h2>
    </div>
  );
  ReactDOM.render(element, document.getElementById('root'));
}

setInterval(tick, 1000);
//这个示例通过 setInterval() 方法，每秒钟调用一次 ReactDOM.render().
//在实际生产开发中，大多数React应用只会调用一次 ReactDOM.render()
// 因此这个方式是行不通的，而是使用：有状态组件 实现 DOM 更新方式!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
```

## 3.3 React 只会更新必要的部分

React DOM 首先会比较元素内容先后的不同，而在渲染过程中只会更新改变了的部分。

![y](https://react.docschina.org/granular-dom-updates-c158617ed7cc0eac8f58330e49e48224.gif)

即便我们每秒都创建了一个描述整个 UI 树的新元素，React DOM 也只会更新渲染文本节点中发生变化的内容。

根据我们以往的经验，将界面视为一个个特定时刻的固定内容（就像一帧一帧的动画），而不是随时处于变化之中（而不是处于变化中的一整段动画），将会有利于我们理清开发思路，减少各种 bug。