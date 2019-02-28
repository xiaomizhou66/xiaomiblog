---
title: 数据类型不符合 
date: '2018/8/19 23:57:28'
categories:
  - ⑮ bug 集合
  - vue 中遇到的 bug
updated:
tags:
comments:
---

# 一、前言

在开发过程中总是会遇到各种各样的错误，有很多的工具给我们快速的去发现错误。

- Chrome 开发者工具，就是每个浏览器都会有的  F12(或者其他快捷键) 
- vue-devtools 工具

# 二、数据 undefined、或者类型不符合要求

## 2.1 数据为 undefined  [Vue warn]: Error in mounted hook: "TypeError: Cannot read property 'fileList' of undefined"

```BASH
[Vue warn]: Error in mounted hook: "TypeError: Cannot read property 'fileList' of undefined"
# 在 mounted 钩子函数的时候出错(已经告诉我们是在哪里出错了！！！！！！！！！！缩小范围)
found in

---> <Addproduct> at src/views/Addproduct/Addproduct.vue # 在 Addproduct.vue 组件发证错误
       <Content>
         <Layout>... (2 recursive calls)
           <Home> at src/views/Home/Home.vue
             <App> at src/App.vue
               <Root>
warn @ vue.runtime.esm.js?2b0e:619
logError @ vue.runtime.esm.js?2b0e:1883
。。。。。。
vue.runtime.esm.js?2b0e:1887 TypeError: Cannot read property 'fileList' of undefined
    at VueComponent.mounted (Addproduct.vue?f3da:246) # mounted 钩子（出错的位置）
    # 有的会在这里支出出错的 methods 中的函数名的，注意看就容易到 bug ！！！！！！！！！！！！！！
    at invokeWithErrorHandling (vue.runtime.esm.js?2b0e:1854)
    at callHook (vue.runtime.esm.js?2b0e:4190)
    at Object.insert (vue.runtime.esm.js?2b0e:3132)
    at invokeInsertHook (vue.runtime.esm.js?2b0e:6307)
    at VueComponent.patch [as __patch__] (vue.runtime.esm.js?2b0e:6526)
    at VueComponent.Vue._update (vue.runtime.esm.js?2b0e:3919)
    at VueComponent.updateComponent (vue.runtime.esm.js?2b0e:4037)
    at Watcher.get (vue.runtime.esm.js?2b0e:4440)
    at Watcher.run (vue.runtime.esm.js?2b0e:4515)
```