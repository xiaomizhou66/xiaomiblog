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

# 二、import 的问题

```JS
//  没有路径表示 node modules
//  加个./表示当前目录
//  main.js
import Vue from 'vue'       // 从 node modules 导入
import App from './App.vue' // 从 当前目录下的 app.vue 文件中导入
import router from './router'// 从 当前目录下的 router 文件中导入
import store from './store' // 从 当前目录下的 store 文件中导入
import iView from 'iview' //从 node modules 导入iview-ui
import 'iview/dist/styles/iview.css' //导入iview.css
import axios from 'axios'
import {
  Message
} from 'iview' //从 node modules 导入 Message
```

# 二、JS

## 2.1 数据为 undefined  [Vue warn]: Error in mounted hook: "TypeError: Cannot read property 'fileList' of undefined" 数据 undefined、或者类型不符合要求

![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190227230359.png)

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

## 2.2 参数不符，语法错误（不一定是 JS 中的函数参数错误，也要看看 html 代码）

```BASH
 ERROR  Failed to compile with 1 errors                                                                                    16:01:53
 error  in ./src/views/Product/Product.vue?vue&type=template&id=40cdf8e5&scoped=true& # 在 Product.vue 页面错误
Syntax Error: SyntaxError: Argument name clash (1:827) # 错误原因：语法错误：参数名称冲突

 @ ./src/views/Product/Product.vue?vue&type=template&id=40cdf8e5&scoped=true& 1:0-402 1:0-402
 @ ./src/views/Product/Product.vue
 @ ./src/router.js
 @ ./src/main.js
 @ multi (webpack)-dev-server/client?http://192.168.2.100:8080/sockjs-node (webpack)/hot/dev-server.js ./src/main.js
 ```

 ```HTML
 <template slot-scope="{ row,row}" slot="name"> <!-- 一直在找 JS 不知道是哪里错了，原来是在 template 写错了！！！！！！ -->
   <div v-if="(row.images)[0]" class="table-img">
     <img :src="(row.images)[0].url" width="100" height="100">
     <div @click="changeText('name',row)">{{row.name}}</div>
   </div>
 </template>
```

## 2.3 localstorage 保存的是 JSON 字符串

localstorage 保存的是 JSON 字符串，我们 JS 中数组或者是对象，这些数据是不能保存到本地的。

例如使用在登录页面。

```JS
//localStorage.setItem("token", `Code ${res.data.token}`);   // 注意如果我们的
localStorage.setItem("sessionToken",JSON.stringify(res.data))// 考虑 token 时效就需要同时获取 返回的 token 过期时间
this.$router.push("/product");
```

# 三、网络 webSoket

## 3.1 IP 网络问题 GET http://192.168.2.100:8080/sockjs-node/info?t=1551497641166 net::ERR_CONNECTION_TIMED_OUT

```BASH
[WDS] Disconnected! # WDS 已断开连接！ （WDS 就是 webSoket 的意思）
GET http://192.168.2.100:8080/sockjs-node/info?t=1551497596005 net::ERR_CONNECTION_TIMED_OUT
# 连接超时
```

>原因：

这是一个常见的互联网错误。
1.发生此 DNS 错误是因为访问或浏览该网站时，Internet IP 地址被防火墙或驱动程序阻止。
但有时这种 DNS 错误可能由几种原因引起，但都是采取一个解决方案。
2.而在 vue 开发中，很大原因是因为网络环境改变了。

>场景：

```BASH
# 2019.03.01 晚上 yarn serve
  App running at:
  - Local:   http://localhost:8080/
  - Network: http://192.168.2.100:8080/
# 项目运行的 ip 是 http://192.168.2.100:8080/
# 然后一直不停止运行
# 2019.03.02 早上打开代码编辑，就会出现这个错误了，
# GET http://192.168.2.100:8080/sockjs-node/info?t=1551497596005 net::ERR_CONNECTION_TIMED_OUT
# 链接超时，因为我们现在不在 http://192.168.2.100:8080 这个环境下。
```

>解决：

1.重新运行项目，将旧的运行停止掉，重新 yarn serve
  App running at:
  - Local:   http://localhost:8080/
  - Network: unavailable  这里就会得到新的 IP ，如果没有新的，可能是因为是公司网络，禁止的问题，权限验证的问题。
2.如果不是 vue 的网络环境，就是 webpack 的配置问题，其他问题？？就要 **清除浏览器历史记录和缓存**，或者是其他的操作来解决问题。

Google Chrome 浏览器清除历史记录和缓存：
1.这里是全部网站：转到“自定义和控制”（Chrome 浏览器右上角） – >然后单击“设置” – >单击下面的“显示高级设置”按钮 – >然后到“隐私”部分 – >点击“清除浏览数据”按钮 – >检查新弹出窗口中的所有框
2.单个网站的清除：打开 审查，之后地址栏前面的圆圈右键就可以直接清除并且重载当前页面。

>延伸学习：

WDS 即 Wireless Distribution System，是无线网络部署延展系统的简称，指用多个无线网络相互联结的方式构成一个整体的无线网络。简单地说，WDS就是利用两个(或以上)无线宽带路由器/AP通过相互连接的方式将无线信号向更深远的范围延伸。利用WDS技术，AP之间可以舍弃传统的有线网络进行互联，每个AP可以作主设备、中继设备和远端设备。

而在 vue 中 WDS 指的是 webpack-dev-server ，学习 webpack-dev-server 原理分析与 HMR 实现。支持无刷新更新数据，也就是实现了我们更新代码，浏览器端就可以立即看到代码的效果改变了，热重载。

webpack-dev-server 在我们的 entry 中添加的 hot 模块内容（热重载 模块）,更多资料可以学习[此篇文章:webpack-dev-server 原理分析与 HMR 实现](https://blog.csdn.net/liangklfang/article/details/56848925).

当客户端接受到服务器端发送的 ok 和 warning 信息的时候，同时支持HMR的情况下就会要求检查更新，同时发送过来的还有服务器端本次编译的 hash 值。我们继续深入一步，看看服务器什么时候发送 ’ok’ 和 ’warning’ 消息：也就是每次 compiler的 ’done’ 钩子函数被调用的时候就会要求客户端去检查模块更新，进而完成 HMR 基本功能！

简单的说就是，我们在配置好的框架下，修改代码，保存文件，触发监视和热加载，浏览器更新。

## 四、iview 的错误

### 4.1 message 通知 在 main.js 的使用!!!!!!!!!!!!!!!!

```JS
//在 .vue 文件中使用是
this.$Notice.open(config)
this.$Notice.info(config)
this.$Notice.success(config)
this.$Notice.warning(config)
this.$Notice.error(config)
```

但是在 main.js 中就不是这样使用的了，

```JS
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import {
  Message
} from 'iview' // Message 一定要以 ES6 这样的方式来引入，不能去掉花括号，不然就错了
import iView from 'iview'
import 'iview/dist/styles/iview.css'
import axios from 'axios'

Vue.config.productionTip = false
Vue.use(iView); //全局使用iview

//。。。。。。。省略一串代码，具体可以去看 axios 拦截器



// 响应拦截
axios.interceptors.response.use((res) => {
  return res;
}, (error) => {
  console.error('response interceptor: ', error)
  var status = error.response.status
  if (status) {
    switch (status) {
      case 401:
        Message.error("登录 token 过期，请重新登录")
        // 但是在这里不要用  this，因为它就不是 vue 实例
        // 并且该文件是直接引入 import router from './router' ，当然可以直接的就使用 router 了！！！！！！！！！！！！！！！！！1
        router.push('/login');
    }
  }
  return Promise.reject(error);
})


new Vue({
  router,// 因为这里的注册，在 .vue 文件才可以使用 this.$router.push
  store,
  render: h => h(App)
}).$mount('#app')
```

特别严重的错误，因为 Message.error("登录 token 过期，请重新登录") 这一句代码的不正确，导致路由不能实现跳转登录页面！！！！！
这里是 iview-ui，那个 element-ui 也是一样的道理，差不多的方法来解决这个 main.js 使用 Message 通知的问题！！！！！！！！！！

### 4.2 router 在 main.js 的使用

```JS
import Vue from 'vue'
import App from './App.vue'
import router from './router'  // 这里导入 router，那么再本页面使用的就是 router 了啦。
import store from './store'
import {
  Message
} from 'iview'
import iView from 'iview'
import 'iview/dist/styles/iview.css'
import axios from 'axios'

Vue.config.productionTip = false
Vue.use(iView);


//。。。。。。。省略一串代码，具体可以去看 axios 拦截器


// 响应拦截
axios.interceptors.response.use((res) => {
  return res;
}, (error) => {
  console.error('response interceptor: ', error)
  var status = error.response.status
  if (status) {
    switch (status) {
      case 401:
        Message.error("登录 token 过期，请重新登录")
        router.push('/login'); //页面跳转，router.replace 不会计入 history
        // 在 .vue 的 js 中用的是 this.$router.replace('/login')
        // 但是在这里不要用  this，因为它就不是 vue 实例
        // 并且该文件是直接引入 import router from './router' ，当然可以直接的就使用 router 了！！！！！！！！！！！！！！！！！1
    }
  }
  return Promise.reject(error);
})


//。。。。。。。省略一串代码
```