---
title: taro.js 多终端框架(京东)
date: '2018/8/19 23:57:28'
categories:
  - 五、react.js
  - taro.js 多终端框架(京东)
abbrlink: 1645f78a
updated:
tags:
comments:
---

# 一、前言

Taro:京东凹凸实验室开源的一款使用 React.js 开发微信小程序的前端框架。它采用与 React 一致的组件化思想，组件生命周期与 React 保持一致，同时支持使用 JSX 语法，让代码具有更丰富的表现力，使用 Taro 进行开发可以获得和 React 一致的开发体验。,同时因为使用了react的原因所以除了能编译h5, 小程序外还可以编译为ReactNative;

taro.js:多端统一开发框架，支持用 React 的开发方式编写一次代码，生成能运行在微信小程序/百度智能小程序/支付宝小程序、H5、React Native 等的应用。

[GitHub](https://github.com/NervJS/taro)
[官方中文文档](https://nervjs.github.io/taro/docs/README.html)

Taro 是一套遵循 React 语法规范的 多端开发 解决方案。使用 Taro，我们可以只书写一套代码，再通过 Taro 的编译工具，将源代码分别编译出可以在不同端（微信小程序、H5、RN 等）运行的代码。不需要针对不同的终端去书写多套代码。

# 二、