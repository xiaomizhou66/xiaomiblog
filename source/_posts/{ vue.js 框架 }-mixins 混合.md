---
title: vue 中的 mixins 使用
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

# 一、前言

混入 (mixins) 是一种分发 Vue 组件中可复用功能的非常灵活的方式。混入对象可以包含任意组件选项。当组件使用混入对象时，所有混入对象的选项将被混入该组件本身的选项。

[vue.js 框架 mixins 混入地址](https://cn.vuejs.org/v2/guide/mixins.html)

# 二、用途

为组件定义可复用的方法，可以在 mixin 对象里定义组件的任何属性，在组件使用 mixin 时，mixin 中的属性会添加到组件属性中。

# 三、使用 mixins

## 3.1 组件内 mixins

```JS
//mixin.js
//page
export default {
  let cache = null // 确保进入和离开是一个page
}
```