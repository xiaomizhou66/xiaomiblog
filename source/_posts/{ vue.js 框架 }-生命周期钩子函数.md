---
title: 'vue--[ 生命周期钩子函数]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue.js 框架学习
abbrlink: cc72d61a
updated:
tags:
comments:
---

## 一、前言

生命周期是一个重点，也是比较难以区分的选项。

## 二、生命周期

```JS
  beforeCreate(){
  //在 **实例初始化**之后，**数据观测 (data observer)** 和 **event/watcher 事件配置** 之前被调用。
  }
  created(){
    //在实例创建完成后被立即调用。
  }
  beforeMount(){
    //在挂载开始之前被调用：相关的 render 函数首次被调用。
  }
  mounted(){
    //el 提供一个在页面上已存在的 DOM 元素作为 Vue 实例的挂载目标
    //注意 mounted 不会承诺所有的子组件也都一起被挂载。如果你希望等到整个视图都渲染完毕，可以用 vm.$nextTick 替换掉 mounted：
  }
  beforeUpdate(){
    //数据更新时调用之前，虚拟 DOM 打补丁之前。
    //适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。
  }
  updated(){
    //由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。
    //updated 不会承诺所有的子组件也都一起被重绘。如果你希望等到整个视图都重绘完毕，可以用 vm.$nextTick 替换掉 updated
  }
  activated(){
    //keep-alive 组件激活时调用
  }
  deactivated(){
    //keep-alive 组件停用时调用。
  }
  beforeDestroy(){
    //实例销毁之前调用。实例仍然完全可用。
  }
  destroyed(){
    //Vue 实例销毁后调用。
    //调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。
  }
  errorCaptured(err,vm,info){
    //当捕获一个来自子孙组件的错误时被调用。
    //(err: Error, vm: Component, info: string) => ?boolean
    //错误对象，发生错误的组件实例，错误来源信息的字符串
    //此钩子可以返回 false 以阻止该错误继续向上传播。
  }
```

![周期图解](http://liuxmoo.foryung.com/lifecycle.png)