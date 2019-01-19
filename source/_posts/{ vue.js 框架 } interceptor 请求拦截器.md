---
title: interceptor 请求拦截器
date: '2018/8/19 23:57:28'
tags:
  - interceptor 请求拦截器
categories:
  - 四、vue.js
  - axios 前后端数据交互
abbrlink: 8a3b30d5
updated:
comments:
---
## 一、 interceptor 简介

interceptor 即使在发送请求之前做的事情。

## 二、interceptor 大致框架

### 2.1 配置拦截器

```JS
// 添加请求拦截器
axios.interceptors.request.use(function (config) {
    // 在发送请求之前做些什么
    return config;
  }, function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
  });

// 添加响应拦截器
axios.interceptors.response.use(function (response) {
    // 对响应数据做点什么
    return response;
  }, function (error) {
    // 对响应错误做点什么
    return Promise.reject(error);
  });
```

### 2.2 移除拦截器

```JS
var myInterceptor = axios.interceptors.request.use(function () {/*...*/});
axios.interceptors.request.eject(myInterceptor);
```

## 三、interceptor 在 vue 中实例应用

### 3.1 token 本地缓存

```JS
//bigdata 项目中的设置
// interceptor/index.js 文件
import axios from 'axios'
import router from 'router'

axios.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {// 发送请求之前给 token 再其他的请求中就不需要给 token 了
    config.headers.Authorization = `${token}`;// 在配置好 token 就不需要在每个axios 都写上 headers 了。
  }
  return config;
}, (error) => {
  console.error('request interceptor: ', error)
  return Promise.reject(error)
})

axios.interceptors.response.use((res) => {
  return res;
}, (error) => {
  console.error('response interceptor: ', error)
  if (error.response.status) {
    switch (error) {
      case 401:
        router.replace('/login');//页面跳转，router.replace 不会计入 history
        // 在 .vue 的 js 中用的是 this.$router.replace('/login')
    }
  }
  return Promise.reject(error);
})
```

### 3.2 token 在 store 中

```JS
import Vue from 'vue';
import router from 'router'
import axios from 'axios';
import store from '../store/';

// 默认配置，这个默认配置可以卸载 interceptor 中也可以写在 main.js  中  ，
// 因为最终 interceptor/index.js 都是在 main.js 全局引入的 import 'interceptors'
axios.defaults.baseURL = 'http://www.xxxx.com';
axios.defaults.headers.post['Content-Type'] = 'application/json';
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;// 在这里写默认的，或者是在 interceptors 中写

export const request = (config) => {
  return axios(config);
};

// http request 拦截器
axios.interceptors.request.use((config) => {
    if(store.state.token) {
      // 判断是否存在token，如果存在的话，则每个http header都加上token
      config.headers.Authorization = `${store.state.token}`;  // token保存在store中
    }
    return config;
  },(err) => {
    return Promise.reject(err);
  }
);

// http response 拦截器
axios.interceptors.response.use((response) => {
    return response;
  },(error) => {
    if(error.response) {
      switch (error.response.status) {
        case 401:
          router.replace({
            path: '/login',
            query: {redirect: router.currentRoute.fullPath}
          });
      }
    }
    return Promise.reject(error.response.data);// (error.response.data 还是 error 自己做。
  }
);
```

## 四、 axios 的全部配置项

具体参考 axios 文章。可以在 main.js 中设置全局配置



这里是一些举例

```JS
//设置请求baseURL
axios.defaults.baseURL = '/api'
//设置默认请求头
axios.defaults.headers = {
"Content-Type": "application/x-www-form-urlencoded"
}
// 发送请求前处理request的数据
axios.defaults.transformRequest = [function (data) {
  let newData = ''
  for (let k in data) {
    newData += encodeURIComponent(k) + '=' + encodeURIComponent(data[k]) + '&'
  }
  return newData
  }]
// 带cookie请求
axios.defaults.withCredentials = true
```