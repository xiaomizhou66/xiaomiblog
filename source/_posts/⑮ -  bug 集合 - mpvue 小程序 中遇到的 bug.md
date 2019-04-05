---
title: 小程序 mpvue 框架 中遇到的 bug
date: '2018/8/19 23:57:28'
categories:
  - ⑮ bug 集合
  - 小程序 中遇到的 bug
updated:
tags:
comments:
---

# 一、前言

小程序 mpvue 框架的问题。

# 二、各种问题

## 2.1 vue-cli 脚手架的版本的问题

截止目前（2019.04.04）mpvue 框架使用的都是 vue-cli2 脚手架搭建的，但是 vue.js 的脚手架其实已经更新到 vue-cli3 版本的了，使用了 vue-cli3 版本时候，就会覆盖 vue-cli2 版本的，如果需要使用 mpvue 来做小程序，就要使用到 `桥接工具` 使用电脑系统同时使用 vue-cli3 与 vue-cli2 版本脚手架。

```BASH
 # 全局安装 桥接工具
$ npm install -g @vue/cli-init

$ # `vue init` 的运行效果将会跟 `vue-cli@2.x` 相同
```

## 2.2 安装 vue-cli2 版本出错

```BASH
λ npm install -g @vue/cli-init
npm WARN deprecated coffee-script@1.12.7: CoffeeScript on NPM has moved to "coffeescript" (no hyphen)
# coffee-script@1.12.7 已经被废弃了：已经被转移到 coffeescript 上面了
#（注意 coffeescript 是没有 no hyphen 连接符的）
+ @vue/cli-init@3.5.1
updated 103 packages in 14.284s

# 解决办法
$ npm install -g coffeescript # 全局安装 coffeescript
```