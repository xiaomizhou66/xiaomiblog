---
title: 'WeChat 微信小程序【11】--[wxml 与 html 的区别使用]'
date: '2018/8/18 21:57:28'
categories:
  - 七、小程序
  - MINA 框架
abbrlink: e3af803d
updated:
tags:
comments:
---

## 一、前言

wxml 与html 都是页面结构，但是 wxml 组件与 html 的区别还是很大的。

## 二、区别

### 2.1 空格输入

**`&nbsp;`**
html 中是需要使用`&nbsp;`,在小程序 wxml 中直接使用`&nbsp;`会出错。微信小程序中在 text 中写空格。`<text decode="nbsp">㊣&nbsp;&nbsp;</text>`

**使用\t**
在 view 中也可以使用\t，但是不管用多少个\t只会起到一个\t的作用。