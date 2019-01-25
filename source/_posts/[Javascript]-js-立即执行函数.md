---
title: 'JavaScript【4】--[立即执行函数 IIFE ]'
date: '2018/8/19 23:57:28'
tags:
  - 立即执行函数
categories:
  - ② Javascript-ES6-Typescript
  - Javascript
updated:
comments:
---
## 一、前言

在 ES6 之前，我们为了让函数立即执行，使用的是的给函数加圆括号 () 的方法。 ES6 之后才是用 let 关键字达到立即执行， let 使用网址：[]()，这里我们就先来了解立即执行函数。

## 二、立即执行函数表达式（IIFE）

在 Javascript 里，圆括号不能包含声明因为这点，当圆括号为了包裹函数碰上了 function 关键词，它便知道将它作为一个函数表达式去解析而不是函数声明。

- 当圆括号出现在 **匿名函数的末尾**想要调用函数时，它会默认将函数当成是 **函数声明**。
- 当圆括号 **包裹函数**时，它会默认将函数作为  **表达式**去解析，而不是函数声明。

```JS
//这两种模式都可以被用来立即调用一个函数表达式，利用函数的执行来创造私有变量

(function () {
  /* code */
}()); //Crockford recommends this one，括号内的表达式代表 函数立即调用表达式

(function () {
  /* code */
})(); //But this one works just as well，括号内的表达式代表 函数表达式
```