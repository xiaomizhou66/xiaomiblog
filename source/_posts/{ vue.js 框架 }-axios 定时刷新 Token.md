---
title: 'axios 定时刷新 Token'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - axios 前后端数据交互
updated:
tags:
comments:
---

# 一、前言

安全起见，或者是业务需求， token 都会设置时效的。

比如说，
1.超时：我们打开一个网页，很久不去操作，再去操作的话可能就需要重新登录了。
2.用户操作期间：前端请求，带上旧的 token 给到服务端，服务端返回一个旧的给前端，看起来就会像是将 token 的时间延长一样，因为服务端判断 token 是否过时
  会以最新的来判断的呢。
  
这样就可以保证用户一直在改网站操作的话就可以一直保持登录状态，离开太久了就会断开登录。

# 二、理解 token

## 2.1 token 身份验证机制

客户端 **登录请求接口** 成功后，服务器将用户信息（如用户 id）使用特殊算法加密后作为验证的标志发送给用户（即 token ），当用户 **下次发起请求*（其他的请求接口，需要依赖验证）** 时，会将这个 token 捎带过来，服务器再将这个 token 通过解密后进行验证，通过的话，则向客户端返回请求的数据；反之，则请求失败。

## 2.2 token 优点

它是无状态的，且服务器不用像传统的身份认证（session）那样需要保存会话信息，减轻了服务器的压力。

## 2.3 vue 的 token 刷新处理

### 2.3.1 token 与 refresh_token

一般为了安全性，token 都会设置一个过期时间，在过期之后就无法请求相关接口，需要重新登录。

比如说，
1.超时：我们打开一个网页，很久不去操作，再去操作的话可能就需要重新登录了。
2.用户操作期间：前端请求，带上旧的 token 给到服务端，服务端返回一个旧的给前端，看起来就会像是将 token 的时间延长一样，因为服务端判断 token 是否过时
  会以最新的来判断的呢。
  
这样就可以保证用户一直在改网站操作的话就可以一直保持登录状态，离开太久了就会断开登录。

### 2.3.1 先来理解后端的思路

登录的时候：前端 提交的用户名，密码，（或者其他要求的信息），后端判断 用户名密码是否是真的用户，通过就会返回一个 token。
           返回的信息中有不仅有 token，还有 token 的过期时间 expire
token 过期判断：前端发送旧的 token 给到后端，后端会解析这个 token（后端会解析到 旧 token 的发放时间，以及过期时间） ，
          判断是否过期，如果不过期就会返回一个新的 token 给到后端。

### 2.3.2 前端代码实现（在拦截器中实现）

>理解需求

登录时请求 token 和 refresh_token(用来刷新token)
每一次请求后端接口的时候都要在 header 里带 token，如果过期会报错 401
在快过期的前半小时内（业务需求而定）用 refresh_token 重新请求可以刷新 token，使用户不必被强制退出重新登录。

>解决思路

拦截器的思路：
    axios 设置的思路是，先设置默认的数据，比如说超时时间，url 前缀，然后设置 request 和 response 拦截器，request 拦截器是在发送请求之前执行，response拦截器是在请求返回之后执行。

刷新 token 的思路：
    定时刷新 token，简而言之就是隔一段时间去刷新一次 token，当然前提是原来的 token 还没有过期的情况下，才能去刷新，否则直接跳回登录首页；
    这里实现刷新 token 主要是在 response拦截器 做文章，请求返回 401 时先记录这次请求的设置 config，然后请求刷新接口，刷新成功之后再重新发送一次之前失败的请求，因为 config 保存下来，所以发送请求的时候可以先把 config 中的 token 换成最新的 token，再直接用 axios(config)，而不用担心其他的设置，从而实现重新请求。
    那么问题在于如何知道刷新 token 成不成功呢，如果无脑反复请求会变成死循环，因此需要设置一个变量在 config 中，请求过刷新接口之后设置这个变量为 true，这样就不会重复刷新了。？？？？？这个思路感觉不怎么对呢？？？
    token 时间限制，但是我们不希望每次请求都去请求新的 token ，应该是快要过期然后去请求新的，？？？感觉不是上面这样解决啊？？

```JS
// main.js 文件（应该是把 拦截器放到其他页面的，但是放置不成功，后面再来更新。。。。。。。。。。）
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import iView from 'iview' //导入iview-ui
import 'iview/dist/styles/iview.css' //导入iview.css
import axios from 'axios'
import {
  Message
} from 'iview'

Vue.config.productionTip = false
Vue.use(iView); //全局使用iview


axios.defaults.baseURL = 'https://api.talcoding.com/v1';
axios.defaults.headers.post['Content-Type'] = 'application/json';

// 要在 axios 拦截器中请求，不能用同一个实例，死循环了，
// 默认的实例是 axios ，这里我们还有自己去创建一个 axios 实例 tokenAxios（名字自己取）
let tokenAxios = axios.create({
  baseURL: 'https://api.talcoding.com/v1'
})


// 请求拦截：带上 token 请求头
axios.interceptors.request.use((config) => {
  //const token = localStorage.getItem('token');
  let sessionToken = JSON.parse(localStorage.getItem("sessionToken")) || ''
  // if (token) {
  if (sessionToken) {
    let expire = new Date(sessionToken.expire).getTime()
    let now = new Date().getTime() //2019-03-02T06:35:07.854Z 改格式
    if (expire > now) { // 判断没过期的情况
      const min30 = 1000 * 60 * 30
      // 如果快到期就去获取新的 token，这里就用自己创建的 tokenAxios 实例来请求
      // 快过期才去请求新的 token 不然就会给服务端压力
      if (expire - now < min30) {
        tokenAxios({
          url: '/session',
          method: 'get',
          headers: {
            Authorization: `Code ${sessionToken.token}`
          }
        }).then((res) => {
          localStorage.setItem("sessionToken", JSON.stringify(res.data))
        })
      }
    }
    config.headers.Authorization = `Code ${sessionToken.token}`;
    //config.headers.Authorization = `${token}`;
    // 如果有 token 就会带上 token，至于带上的 token 是否过期就让后端逻辑去判断，在响应的时候做拦截
  }

  console.log(config);

  return config;
}, (error) => {
  console.error('request interceptor: ', error)
  return Promise.reject(error)
})

// 响应拦截：
// 判断 token 是否过期，如果过期就跳转登录页面
// 响应拦截的时候处理 token 是否过时,过期时间是通过后端设置的，前端需要判断 token 的状态码是否过时就行
axios.interceptors.response.use((res) => {
  return res;
}, (error) => {
  console.error('response interceptor: ', error)
  var status = error.response.status
  if (status) {
    switch (status) {
      case 401:
        Message.error("登录 token 过期，请重新登录")// 注意这里的写法是 Message.error ！！！！！！不要有 this
        router.push('/login'); //页面跳转，router.replace 不会计入 history
        // 在 .vue 的 js 中用的是 this.$router.replace('/login')
        // 注意写法是 router.push('/login') ！！！！！！！！！！！！！！！！！！！！！！！！！！！！不要有 this
    }
  }
  return Promise.reject(error);
})


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
```