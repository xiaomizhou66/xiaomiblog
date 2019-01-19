---
title: '[ dayjs 库]--moment.js 的轻量级 '
date: '2018/8/19 23:57:28'
categories:
  - 八、JS 工具集/ JS拓展语言
  - day.js 框架
abbrlink: caaabfec
updated:
tags:
comments:
---

## 一、前言

时间格式处理库，在很多时候，我们的页面需要使用到时间日期，但是格式却是有要求的，这个 dayjs 就是一个处理库。

Day.js 是一个轻量的处理时间和日期的 JavaScript 库，和 Moment.js 的 API 设计保持完全一样.**Day.js 虽然仅有 2kb 大小，但是功能一点都没有阉割。包含了时间处理的全部常用方法。**

Day.js -- 2kB超轻量时间库
Moment.js -- 200k+ with locals(可能一般项目也只使用到了她几个常用的API ,因此 dayjs 更好用于时间处理)

- 🕒 和 Moment.js 相同的 API 和用法
    比 moment.js 轻量级
- 💪 不可变数据 (Immutable)
- 🔥 支持链式操作 (Chainable)
    dayjs().startOf('month').add(1, 'day').set('year', 2018).format('YYYY-MM-DD HH:mm:ss');
- 🌐 I18n 国际化
- 📦 仅 2kb 大小的微型库
- 👫 全浏览器兼容

[GitHub 地址](https://github.com/iamkun/dayjs)
[掘金地址：作者](https://juejin.im/post/5ade86ce518825673277da67)

## 二、安装

```bash
# 安装
$ npm install --save dayjs
```

## 三、 dayjs 使用

Day.js 有很多 API 来解析、处理、校验、增减、展示时间和日期

### 3.1 解析

```JS
// 解析：当前时间
var now = dayjs() // 获取当前时间
var now = dayjs(new Date())// 获取当前时间
dayjs(Date.now() - 24 * 60 * 60 * 1000) // 昨天


// 解析：字符串 dayjs(String);
var day = dayjs('1995-12-25') // 1995-12-25
var day = dayjs('2018-08-08') // 2018-08-08

//警告：浏览器对解析字符串的支持不一致。由于没有关于应支持哪种格式的规范，因此在某些浏览器中有效的功能将无法在其他浏览器中使用。
//为了解析除 ISO 8601 字符串以外的任何其他内容的一致结果，您应该使用 String + Format。

//格式化
dayjs().format('YYYY年MM月DD日 HH:mm:ss') // 2018年08月08日 00:00:00
dayjs().format('[YYYY]') // "[2018]"。     [] 里的会原样输出。
dayjs().format('{YYYY} MM-DDTHH:mm:ss SSS [Z] A') //

//操作
dayjs().add(7, 'days') // 之后的第7天
dayjs().add(1, 'year') // 之后的第 1 年
dayjs().subtract(1, 'months') // 上个月
dayjs().startOf('months') // 获取一月初
dayjs().endOf('year') // 获取一年年末
dayjs().set('month', 3).month() //

//查询
dayjs('2010-10-20').isBefore('2010-10-21') // 早于
dayjs('2010-10-20').isAfter('2010-10-19') // 晚于
dayjs().isLeapYear() // 闰年
dayjs().isBefore(dayjs()) // 查询



```
