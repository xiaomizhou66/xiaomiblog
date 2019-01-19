---
title: css--[盒状模型：display:inline-block + position 属性 + float 属性]
date: 2019/8/15 21:57:26
categories:
  - ① html-css
  - css1
updated:
tags:
comments:
---
## 一、前言

网页布局（layout）是 CSS 的一个重点应用。

布局的传统解决方案，基于盒状模型，依赖 display 属性 + position 属性 + float 属性。

但是它对于那些特殊布局非常不方便，比如，垂直居中就不容易实现。

2009年，W3C 提出了一种新的方案：Flex 布局，可以简便、完整、响应式地实现各种页面布局。目前，它已经得到了所有浏览器的支持，这意味着，现在就能很安全地使用这项功能。flex布局：[网址](https://liuxmoo.com/2018/08/17/2.2.1-css3-flex/)

本文还是继续说依赖 display 属性 + position 属性 + float 属性的布局方式。