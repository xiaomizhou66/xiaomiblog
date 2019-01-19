---
title: WeChat 微信小程序--wepy-redux 状态管理器
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - wepy 框架
abbrlink: 9007ddf0
updated:
tags:
comments:
---

## 一、前言

wepy-redux 状态管理器，类似于 vue 中的 vuex 状态管理器。

[redux 中文文档](https://www.redux.org.cn/)
Redux 是 JavaScript 状态容器，提供可预测化的状态管理。 (如果你需要一个 WordPress 框架，请查看 Redux Framework。)可以让你构建一致化的应用，运行于不同的环境（客户端、服务器、原生应用），并且易于测试。不仅于此，它还提供 超爽的开发体验，比如有一个时间旅行调试器可以编辑后实时预览。

Redux 除了和 React 一起用外（react-redux），还支持其它界面库。 它体小精悍（只有2kB，包括依赖）。本章就是我们要学习的与 wepy 结合使用。

[wepy-redux](https://www.npmjs.com/package/wepy-redux)
[wepy-redux gitHub 仓库](https://github.com/Tencent/wepy/blob/2.0.x/packages/wepy-redux/README.md)

**wepy-redux 只能在 wepy 框架使用。**（mpvue 使用的是 vue 的 vuex）

## 二、 wepy-redux 的安装

```BASH
npm install wepy-redux --save  # 安装 wepy-redux
# 在用 wepy-cli 创建项目的时候就会选择安装的，不需要额外的安装
```

### 2.1 什么时候使用 redux

跟 vuex 一样，不是所有的项目都使用状态管理器的。

在大型应用设计上我们用 redux 来管理那些多个页面需要使用到的数据。也就是说小型设计就没有必要用了， app.wpy 就可以解决数据公用问题了。也不是什么数据都放在 redux 来管理， redux 管理的数据越少才越好。

### 2.2 redux 作用

多个组件共享状态时，单向数据流的简洁性很容易被破坏：

- 多个视图依赖于同一状态。
- 来自不同视图的行为需要变更同一状态。

对于问题一，传参的方法对于多层嵌套的组件将会非常繁琐，并且对于兄弟组件间的状态传递无能为力。对于问题二，我们经常会采用父子组件直接引用或者通过事件来变更和同步状态的多份拷贝。以上的这些模式非常脆弱，通常会导致无法维护的代码。

因此，我们为什么不把组件的共享状态抽取出来，以一个全局单例模式管理呢？在这种模式下，我们的组件树构成了一个巨大的“视图”，不管在树的哪个位置，任何组件都能获取状态或者触发行为！另外，通过定义和隔离状态管理中的各种概念并强制遵守一定的规则，我们的代码将会变得更结构化且易维护。
这就是 Vuex 背后的基本思想。

## 三、 wepy-redux 的使用

```BASH
# 这里是 wepy-cli 创建的目录中，sore 与 .wpy 文件部分
|   ├── components    # （生成） WePY 组件目录（组件不属于完整页面，仅供完整页面或其他组件引用）
|   |   ├── com_a.wpy #  可复用的 WePY 组件 a
|   |   └── com_b.wpy # 可复用的 WePY 组件 b
|   |
|   ├── pages         # （生成）WePY 页面目录（属于完整页面）
|   |   ├── index.wpy # index 页面（build 后，在 dist 目录下的 pages 目录
|   |   |              #生成 index.js、index.json、index.wxml、index.wxss 文件）
|   |   └── other.wpy # other 页面（build 后，在 dist 目录下的 pages 目录）
|   |                  # 生成 other.js、other.json、other.wxml和other.wxss文件
|   |
|   ├── store      # （生成） Redux 状态管理器，类似 vue 的 vuex。对于构建大型应用，对里面共享数据、状态的管理非常方便
|   |   ├── actions/        #（生成）
|   |   |    └──counter.js #（生成）
|   |   |    └──index.js   #（生成）
|   |   |
|   |   ├── reducers/       # （生成）reducers 文件件存放我们的纯函数，用来更改我们的状态
|   |   |    └──counter.js # （生成）定义函数
|   |   |    └──index.js   # （生成）暴露函数
|   |   |
|   |   ├── types/           # （生成）常量定义：用于定义我们要触发的 action 的名称
|   |   |    └──counter.js  # （生成）定义常量
|   |   |    └──index.js    # （生成）暴露常量
|   |   |
|   |   └──index.js   # （生成）入口文件，主要是 初始化 Redux，其中 promiseMiddleware 是一个中间件，方便后面 action 做异步处理
|   |
|   └──── app.wpy
```

### 3.1 store/  => 编辑 store

#### 3.1.1 types 文件夹：用于定义我们要触发的 action 的名称

types 用于定义我们要触发的 action 的名称，也就是表示 action 的名称，这里定义了 counter 和 list 两个 types ，内容分别如下：

```JS
//① store/types/counter.js
//定义 action 的名称-类型 type
export const INCREMENT = 'INCREMENT'
export const DECREMENT = 'DECREMENT'
export const ASYNC_INCREMENT = 'ASYNC_INCREMENT'
```

```JS
//② store/types/list.js
export const ADD = 'ADD'
export const REMOVE = 'REMOVE'
```

```JS
//store/types/index.js  通过 types 文件夹的入口文件 index.js 将他们暴露出去
export * from './counter'
export * from './list'
```

#### 3.1.2 actions 文件夹：用于触发的 action

```JS
//① store/actions/counter.js
import { ASYNC_INCREMENT } from '../types/counter'
import { createAction } from 'redux-actions'

export const asyncInc = createAction(ASYNC_INCREMENT, () => {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve(1)
    }, 1000)
  })
})
```

```JS
//store/actions/index.js  通过 actions 文件夹的入口文件 index.js 将他们暴露出去
export * from './counter'
```

#### 3.1.3 reducers 文件夹：

```JS
//① store/reducers/counter.js
import { handleActions } from 'redux-actions' //引入了 handleActions 方法用来创建 actions
import { INCREMENT, DECREMENT, ASYNC_INCREMENT } from '../types/counter'

export default handleActions({
  [INCREMENT] (state) {
    return {
      ...state,
      num: state.num + 1
    }
  },
  [DECREMENT] (state) {
    return {
      ...state,
      num: state.num - 1
    }
  },
  [ASYNC_INCREMENT] (state, action) {
    return {
      ...state,
      asyncNum: state.asyncNum + action.payload //payload 是传来的参数 action 带来的，调用的时候要给这属性
    }
  }
}, {
  num: 0,
  asyncNum: 0
})
```

```JS
//② store/reducers/list.js
import { handleActions } from 'redux-actions'
import { ADD , REMOVE } from '../types/list'

const defaultState = [
  {
    title : '吃饭' ,
    text : '今天我要吃火锅'
  },
  {
    title : '工作' ,
    text : '今天我要学习Redux'
  }
]

export default handleActions({
  [ADD]( state , action ){
    state.push(action.payload)
    return [...state]
  },
  [REMOVE]( state , action ){
    state.splice( action.payload , 1 );
    return [ ...state ]
  }
},defaultState)
```

```JS
//store/reducers/index.js  通过 actions 文件夹的入口文件 index.js 将他们暴露出去
import { combineReducers } from 'redux'
import counter from './counter' // 导入 counter
import list from './list'       // 导入 list

export default combineReducers({
  counter,
  list
})
```

### 3.2 store/index.js => 初始化 store

```JS
// store/index.js
import { createStore, applyMiddleware } from 'redux' // 导入 redux
import promiseMiddleware from 'redux-promise'
import rootReducer from './reducers'

export default function configStore () {
  const store = createStore(rootReducer, applyMiddleware(promiseMiddleware))
  return store
}

//使用包含自定义功能的 middleware 来扩展 Redux 是一种推荐的方式。 Middleware 可以让你包装 store 的 dispatch 方法来达到你想要的目的
// promiseMiddleware 是一个中间件，方便后面 action 做异步处理~ reducers 是一个纯函数，
// 用于接受 Action 和当前 State 作为参数，返回一个新的 State
```

### 3.3 app.wpy => 获取 sotre

```JS
// app.wpy
import wepy from 'wepy'
import 'wepy-async-function'

import { setStore } from 'wepy-redux' // 导入 wepy-redux  赋予对象 setStore
import configStore from './store'    //  从 store 仓库 导入 wepy-redux 状态管理器 对象 命名 为configStore

const store = configStore() // 调用 状态管理器对象 configStore 的函数 configStore()  返回值赋值给 store
setStore(store) // set!!  设置初始化 store

export default class extends wepy.app {
  config = {}
  globalData = {}
}
```

### 3.4 pages.wpy && common.wpy => 使用 sotre

#### 3.4.1 store 的方法

Store 有以下职责：

- 维持应用的 state；                     `记住在 store 中 state 是树结构的 对象`
- 提供 getState() 方法获取 state;        `wepy.$store.getState().xxxxName`
- 提供 dispatch(action) 方法更新 state； `wepy.$store.dispatch({ type : 'REMOVE' , payload : index })`
- 通过 subscribe(listener) 注册监听器;
- 通过 subscribe(listener) 返回的函数注销监听器。

```HTML
<!-- index.wpy -->
<template lang="wxml">
  <view class="container">
    <text>同步{{ num }}</text>
    <text>异步{{ asyncNum }}</text>
    <button @tap="increment" type="primary">加一</button>
    <button @tap="decrement" type="primary">减一</button>
    <button @tap="asyncIncrement" type="primary">异步加一</button>
      <button @tap="addList">添加</button>
      <view class="box">
        <view class="item" wx:for-items="{{ todoList }}" wx:key="index">
            <view class="title">{{ item.title }}</view>
            <view class="content">{{ item.text }}</view>
            <button type="primary" class="delete" @tap="delete({{index}})">删除</button>
        </view>
    </view>
  </view>
</template>
<script>
import wepy from 'wepy'
import { connect } from 'wepy-redux'  // 导入链接辅助器 connect
import { INCREMENT , DECREMENT } from '../store/types/counter' // 导入 types 下？？？
import { asyncInc } from '../store/actions'  // 导入 actions 下？？？？

  @connect({
    stateNum (state) { // 创建一个数据 stateNum 它是获取 store 中的 state.counter.num
      return state.counter.num
    },
/*     num (state) { // 创建一个数据 num 它是获取 store 中的 state.counter.num （与上面的是一样的啦）
      return state.counter.num // 所以名字是自己去的，用来在 template 中 {{num}}  做数据绑定使用的。
    }, */
    asyncNum (state) { // 创建一个数据 asyncNum 它是获取 store 中的 state.counter.asyncNum
      return state.counter.asyncNum
    },
    sumNum (state) { // 创建一个数据 sumNum 它是获取 store 中的 state.counter.num
      return state.counter.num + state.counter.asyncNum//与 state.counter.asyncNum 只和
    }
  }, {
    incNum: INCREMENT, //？？？？
    decNum: DECREMENT,//？？？？
    asyncInc //？？？？？
  })

  //connect() 函数,它接收一个配置对象config，
  // 当 num 被 wepy.$store.dispatch()
  // 然后，stateNum 会自动执行，返回一个对象，返回的对象属性会自动注入到组件的 data 中，从而更新视图。

  export default class Index extends wepy.page {
    components = {}
    computed = {
      todoList(){
        return wepy.$store.getState().list;
      }
    }
    methods = {
      delete(index){
        wepy.$store.dispatch({ type : 'REMOVE' , payload : index })
      },
      addList(){
        wepy.$store.dispatch({ type : 'ADD' , payload : {
        title : '学习' ,
          text : '好好学习'
        }})
      }
    }

    onLoad () {
      console.log(wepy.$store.getState())
    }
  }
</script>
  <style lang="less">
      text{
          display: block;
          text-align: center;
          margin: 10px auto;
      }
      button{
          width: 90%;
          display: block;
          margin: 10px auto;
      }
      .item{
          display: flex;
          align-items: center;
          text-align: center;
          padding: 0 15px;
          .title{
              font-size: 14px;
              line-height: 20px;
              margin: 10px auto;
          }
          .content{
              font-size: 15px;
              flex: 1;
          }
          .delete{
              width: 70px;
              height: 40px;
              line-height: 40px;
          }
      }
  </style>
```

