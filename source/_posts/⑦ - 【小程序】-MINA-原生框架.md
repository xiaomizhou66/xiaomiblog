---
title: MINA 框架 入门学习
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - MINA 框架
updated:
tags:
comments:
---

## 一、前言

在我们使用官网微信小程序开发工具，创建空项目的时候，可以选择快读启动模板。这个开发者工具就是官方使用了一个MINA框架使其得以工作。

小程序提供的开发框架为 MINA 框架，它类似于 淘宝 Weex 框架、Vue 框架。MINA 框架通过封装微信客户端提供的文件系统、网络通信、任务管理、数据安全等基础功能，对上层提供一整套 JavaScript API,让开发者能够非常方便地使用微信客户端提供的各种基础功能与能力，快速构建一个应用。

## 二、MINA框架结构

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

怎么去了解一个程序的架构呢，一般都是以 hello world 示例来解析的。

![结构](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180901002140.png)

- 一级目录下的四个文件为全局文件。
- pages文件夹为页面设计
- utils文件夹为模块设计

也就是一级目录是小程序注册 js 文件，全局配置 json，全局样式 wxss。还有 g 开发者工具的配置。
页面在 pages 文件夹中，每个页面由 4 种文件构成，json 配置，wxml 页面结构，wxss 页面样式，js页面交互

## 四、MINA框架的工作原理

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
小程序入口文件为 app.js，也就是小程序的注册文件。

## 五、各个文件解析

### 5.1 【JSON 配置文件】

小程序中，包含唯一的全局配置文件 app.json，以及每个页面的配置文件 page.json。每单页页面相应的 JSON 文件会覆盖与 app.json 相同的配置项。

#### 6.1.1 全局配置文件app.json

[官网app.json地址](https://developers.weixin.qq.com/miniprogram/dev/framework/config.html#%E5%85%A8%E5%B1%80%E9%85%8D%E7%BD%AE)

app.json 件用来对微信小程序进行全局配置，决定页面文件的路径、窗口表现、设置网络超时时间、设置多 tab 等。
注意事项：

- ①下面是有注释的，实际使用的时候删除项目中 json 文件的注释， json 文件是不支持注释的。
- ②颜色大多有要求，官方文档有说明，比如`"navigationBarTextStyle"`只有两种颜色black/white
- ③其他带 color 的属性需要设置颜色，均采用 rgb 格式，颜色名称无法正确解读。

```JSON
"pages": [ //设置页面的路径
  "pages/index/index", //写在第一个的默认为首页
  "pages/logs/logs"  //不需要写 index.wxml,index.js,index,wxss,框架会自动寻找并整合  
],
"window": { //设置默认窗口的表现形式
  "navigationBarBackgroundColor": "#ffffff", //顶部导航栏背景色
  "navigationBarTextStyle": "black", //顶部导航文字的颜色 black/white
  "navigationBarTitleText": "微信接口功能演示", //顶部导航的显示文字
  "backgroundColor": "#eeeeee", //窗口的背景色
  "backgroundTextStyle": "light", //下拉背景字体、loading 图的样式，仅支持 dark/light
  "enablePullDownRefresh": false //是否支持下拉刷新 ，不支持的话就直接不写！
},
"tabBar": { //底部 tab 或者顶部 tab 的表现，是个数组，最少配置  个，最多 5 个
  "list": [{ //设置 tab 的属性，最少 2 个，最多 5 个
    "pagePath": "pages/index/index", //点击底部 tab 跳转的路径
    "text": "首页", //tab 按钮上的文字
    "iconPath": "../img/a.png", //tab图片的路径
    "selectedIconPath": "../img/a.png" //tab 在当前页，也就是选中状态的路径
  }, {
    "pagePath": "pages/logs/logs",
    "text": "日志"
  }],
  "color": "red", //tab 的字体颜色
  "selectedColor": "#673ab7", //当前页 tab 的颜色，也就是选中页的
  "backgroundColor": "#2196f3", //tab 的背景色
  "borderStyle": "white", //边框的颜色 black/white
  "position": "bottom" //tab处于窗口的位置 top/bottom
  },
"networkTimeout": { //默认都是 60000 秒一分钟
    "request": 10000, //请求网络超时时间 10000 秒
    "downloadFile": 10000， //链接服务器超时时间 10000 秒
    "uploadFile": "10000", //上传图片 10000 秒
    "downloadFile": "10000" //下载图片超时时间 10000 秒
  },
"debug": true //调试，项目上线后，建议关闭此项，或者不写此项
```

#### 7.1.2 页面配置文件 pages.json，eg：index.json、logs.json

每一个小程序页面也可以使用 .json 文件来对本页面的窗口表现进行配置。只是多了一项`"disableScroll": true`,**页面的配置只能设置 app.json 中部分 window 配置项的内容**，页面中配置项会覆盖 app.json 的 window 中相同的配置项。

[官网pages.json地址](https://developers.weixin.qq.com/miniprogram/dev/framework/config.html#%E9%A1%B5%E9%9D%A2%E9%85%8D%E7%BD%AE)

```JSON
"window": { //设置默认窗口的表现形式
  "navigationBarBackgroundColor": "#ffffff", //顶部导航栏背景色
  "navigationBarTextStyle": "black", //顶部导航文字的颜色 black/white
  "navigationBarTitleText": "微信接口功能演示", //顶部导航的显示文字
  "backgroundColor": "#eeeeee", //窗口的背景色
  "backgroundTextStyle": "light", //下拉背景字体、loading 图的样式，仅支持 dark/light
  "enablePullDownRefresh": false, //是否支持下拉刷新 ，不支持的话就直接不写！
  "disableScroll": true//  设置 true 不能上下滚动，true/false，
                         //注意 disableScroll 只能在 page.json 中有效，无法在 app.json 中设置该项。
}
```

#### 7.1.3 开发工具配置文件 project.config.json

### 7.2 【JS 逻辑层】

小程序的逻辑层由 JavaScript 语言完成。但因为小程序不在浏览器中运行，所以 JS 在 web 浏览器中的一些函数不能用，如 document、window 等。app.js 有全局的小程序生命周期，page.js 有自己本页面的生命周期。

#### 7.2.1 注册小程序 app.js

[官网app.js地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/app.html)

这一步骤，有这几个需要注意的地方：

- 必须在 app.js 中，使用 app() 函数注册微信小程序。全局小程序中，只能注册一次；
- 不能在 app() 内的函数中调用 getApp()（小程序实例），使用 this 就可以拿到小程序的实例；
- 不要在 onLaunch 的时候 getCurrentPage()，因为此时 page 还没有生成；
- 通过其他子页面调用 getApp() 获取实例后，不要私自调用小程序全局的生命周期方法；
- 可以通过 var app=getApp() 获取小程序的实例。

```JS
app ( {
  // 小程序生命周期的各个阶段
  onLaunch: function(){},//当小程序初始化完成时，会触发 onLaunch（全局只触发一次）
  onShow: function(){},//当小程序启动，或从后台进入前台显示，会触发 onShow
  onHide: function(){},//当小程序从前台进入后台隐藏，会触发 onHide
  onError: function(){},//当小程序发生脚本错误，或者 api 调用失败时，会触发 onError 并带上错误信息
  onPageNotFound:function(){},
  globalData: { //全局数据，pages 页面调用 app.js 全局数据方式看下面
    userInfo: null
    // 自定义，用 this可以访问
  },
  getName:function(){
    return '这里是app.js里面的自定义方法'
    // 自定义函数与属性，用 this 可以访问
  }
})
```

**pages页面调用app.js全局数据方式**

```JS
App({// app.js
  globalData: 1
})
// 某 page.js
console.log(getApp().globalData)
//事实上不是这样，pages 页面都会先实例化 app.js 的。
//const app=getApp()
//获取数据只需要 app.globalData
```

#### 7.2.2 注册小程序页面 page.js eg：index.js 还有其他新建的页面

[官网pages.js地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html)

Page() 用来注册一个页面，维护该页面的生命周期以及数据。

```JS
Page({
  data: { //页面的初始数据,第一次渲染的数据，后面会根据下面的方法/事件得以改变
    text: 'init data',//调用：{{text}}
    array: [{
      msg: '1'   //调用：{{array[0].msg}}
    }, {
      msg: '2'
    }]
  },
  // 页面生命周期的各个阶段
  onLoad: function () {}, //生命周期函数--监听页面加载
  onShow: function () {}, //生命周期函数--监听页面显示/或者置位前台
  onReady: function () {}, //生命周期函数--监听页面初次渲染完成
  onHide: function () {}, //生命周期函数--监听页面隐藏
  onUnload: function () {}, //生命周期函数--监听页面卸载/销毁（重定向/返回，置为后台）
  onPullDownRefresh: function () {}, //页面相关事件处理函数。如果需要监听用户下拉动作，需要 在app.json中配置  
  onReachBottom: function () {}, //页面上拉触底事件的处理函数
  onShareAppMessage: function () { //用户点击右上角分享
  //需要在 wepy.page 中设置才有效果，在 wepy.component 中设置无效果。
    return {
      title: '自定义分享标题',
      desc: '自定义分享描述',
      path: '/page/user?id=123',
      success(res){
        // 转发成功
        let shareId = res.shareTickets[0]
        wepy.getShareInfo({
          shareTicket: shareId,
          success(res){
            //
            var appId = '小程序的appID'
            var encryptedData = res.encryptedData
            var iv = res.iv
            wepy.request({
              url: 'http://localhost:3000/api/decode',
              method: 'post',
              data: {
                appId: appId,
                encryptedData: encryptedData,
                iv: iv
              },
              success: (info) => {
                console.log('info:' + info)
              },
              fail: (info) => {
                console.log(info)
              }
            })
          },
          fail(res){
            //console.log
          }
      },
      fail(res){
        //转发失败
      }
    }
  },
  onPageScroll: function () {},//页面滚动触发事件的处理函数
  onTabItemTap: function () {},//当前是 tab 页时，点击 tab 时触发
  //上面的是小程序默认存在的函数，我们可以写一下自定义函数/属性
  // 自定义函数或者属性如：用于组件事件处理函数，在 .wxml 组件中绑定的自定义名称的函数，
  //具体可以学习 wxml 的事件函数再明白这里
  customData: {
    hi: 'MINA'
  }...
})
```

**pages页面**

- 初始数据：data
- 生命周期回调函数：onLoad、onShow、onReady、onHide、onUnload
- 页面事件处理函数：onPullDownRefresh、onReachBottom
- 组件事件处理函数：在wxml绑定的自定义的函数
- route：this.route 可以获取到当前页面的路径
- setData：将数据从逻辑层发送到视图层（异步），同时改变对应的 this.data 的值（同步）。
- 页面生命周期:[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html#%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F)

**组件事件处理函数：在wxml绑定的自定义的函数**：[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html#%E7%BB%84%E4%BB%B6%E4%BA%8B%E4%BB%B6%E5%A4%84%E7%90%86%E5%87%BD%E6%95%B0)

```HTML
<view bindtap="viewTap"> click me </view>
```

```JS
Page({
  viewTap: function() {
    console.log('view tap')
  }
})
```

**setData**[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html#pageprototypesetdataobject-data-function-callback)

```JS
//index.js
Page({
  data: {
    msg: 'msg',
    num: 0,
    array: [{textArr: 'init data'}],
    object: {
      text: 'init data'
    }
  },
  changeText: function() {
    // this.data.text = 'changed data'  // bad, it can not work，不能这样直接修改，需要使用 setData 来修改才会生效的
    this.setData({
      msg: 'changed data'
    })
  },
  changeNum: function() {
    this.data.num = 1//遇到需要计算的，就放在 this.setData 外面来计算，this.setData 只能直接赋值，官方中有的地方在 setData 中赋值，那是它没有更新文档，其实是不行的！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    //！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    this.setData({
      num: this.data.num
    })
  },
  changeItemInArray: function() {
    // you can use this way to modify a danamic data path
    // 可以使用字符串的办法去构造 数组 或者 对象中的某个字段，这样做通常比修改整个对象或数组更好
    // 当然如果整个数组或者对象都需要修改的话就直接修改整个就 ok）
    this.setData({
      'array[0].textArr':'changed data'//构造数组中 项 中的 对象下的 textArr 字段
    })
  },
  changeArray:function(){
    this.setData({
      array: newArry//对整个数组的值都需要改变的话，就直接这样改变就好了，对象也是一眼的道理。
    })
  },
  changeItemInObject: function(){
    this.setData({
      'object.text': 'changed data' // 构造 object 对象中的 text
    });
  },
  addNewField: function() {
    this.setData({
      'newField.text': 'new data'
    })
  }
})
```

**log.js场景值页面**

这个页面不是我们需要做的展示页面
[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/scene.html)

#### 7.2.3 公共模块utils.js

公共模块方法需要通过 module.exports 对外暴露接口，使用的时候需要利用 require(path)，将文件引入。

```JS
function sayHello(name) {//公共方法util类
  console.log(`Hello ${name} !`)
}
module.exports.sayHello = sayHello//用module.exports 对外暴露接口
```

```JS
//先引入文件，是新建的一个 utils 包，公共方法在 util.js 里面
var util = require('../../utils/util.js')
Page({//调用类
  onLoad: function () {//  使用时，用 util 引用名调用，如：util.sayHello()
    util.sayHello('我是传的值');
  }
})
```

#### 7.2.4 路由

MINA 框架不需要我们去设置路由，框架自身完成了路由设置。还提供了API接口
[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/route.html)

#### 7.2.5 模块化

小程序之所以火，原因之一，因为它小。固然我们代码不能大，微信审核通过的代码不能超过 4M，否则审核不通过。那么如何优化代码是关键，模块化就是其一优化。可以将一些公共的代码抽离成为一个单独的 js 文件，作为一个模块。模块只有通过 module.exports 或者 exports 才能对外暴露接口。[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/module.html)，有同步API，异步API供我们直接调用

#### 7.2.6 API

小程序开发框架提供丰富的微信原生 API，可以方便的调起微信提供的能力，如获取用户信息，本地存储，支付功能等。详细介绍请参考 API 文档。[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/api.html)

#### 7.2.4 js文件数据操作

setData() 不能直接操作数据，例如 this.data.text="xxxxx" 就是错误的。你需要在 this.setData () 之中，进行数据的操作。

同时，这里有作用域的问题。比如，需要在局部函数中使用，就需要 .bind(this)。

### 7.3 【WXML视图层】

#### 7.3.1 wxml 的标签/组件-组件对应属性

学习者这里的时候应该先去学习 wxml，也就是标签/组件的学习， 以及它的属性，属性值的学习。
官网：[地址](https://developers.weixin.qq.com/miniprogram/dev/component/view.html)

视图层的数据绑定均来自于 Page 中的 data，想要修改相应值，你需要用到 this.setData。数据绑定使用两对花括号，将变量名包起来。

**wxml的内容**：[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxml/data.html)

- 数据绑定：{{data}}
- 列表渲染：`<view wx:for="{{array}}"> {{index}}:{{item}} </view>`
- 条件渲染：`<view wx:elif="{{length > 2}}"> 2 </view><view wx:else> 3 </view>`
- 模板
- 事件
- 引用

#### 7.3.2 双花括号：数据绑定

```HTML
<!-- .wxml文件 -->
<view>
    <text>{{msg}}绑定文本<text>
    <text>{{msg+1}}绑定文本表达式<text>
    <text id="id-{{id}}">绑定属性</text>
    <text data-name="{{thename}}">绑定属性</text>
    <view hidden="{{flag}}">js中flag为布尔值</view>
    <view hidden="{{flag?true:false}}">
        绑定三元表达式属性
    </view>
</view>
```

```JS
<!-- .js文件 -->
Page({
  data: {
    msg:18,
    thename: 'xiaomi',
    flag: false
  }
})
```

#### 7.3.3 条件渲染

你可以利用 if 和 else，在视图层上编写在特定情况下，出现的不同的视图结果。

```HTML
<view wx:if="{{zhenjiaa=='123'}}">123334</view>
<view wx:if="{{zhanjia}}">123334</view>
<view wx:if="{{len > 5}}">大于5我就显示了 </view>
<view wx:if="{{length > 5}}"> 1 </view>
<view wx:elif="{{length > 2}}"> 2 </view>
<view wx:else> 3 </view>
<view>
  <block wx:if="{{true}}">
  <view> view1 </view>
  <view> view2 </view>
  </block>
</view>
```

很多人会将 CSS 中的 display: hidden 属性，将其做一个比较。

微信小程序中的 wx:if 是惰性的。如果不符合渲染条件，它不会渲染相应部分；
使用 display: hidden 时，元素始终渲染，只是视图层上没有显示，用户看不见。
如果你的小程序有元素显示频繁切换的需求，建议你使用 display: hidden，能够为用户提供能顺畅的使用体验。

#### 7.3.2 列表渲染

相当于让 WXML 处理一个循环。

**①数组循环**： {{index}}:{{item}}

在 WXML 中，你可以这样来建立一个 for 循环：必须是 index 与 item

```HTML
<view wx:for="{{array}}"> {{index}}:{{item}} </view>
```

然后在相应的 JS 中，新建一个数组：

```JS
page.jsPage({
  data: {
    array: [1, 2, 3, 4, 5]
  }
})
```

需要注意的是，如果列表中的项需要动态添加到列表中，并希望项目保持原有的特征和状态，那么你应该使用 wx:key。wx:key 有两种形式：字符串：wx:key="unique",保留关键字：wx:key="*this"

**②对象循环**： {{index}}:{{item.xxxkey}}

默认的索引值为index，item，也可以自定义，但是好像没有什么意义啊？？？还给自己浪费时间写代码??不是，在复杂数据中这个是很有用的

```HTML
<view wx:for="{{array}}" wx:for-index="aa"  wx:for-item="bb"> {{aa}}:{{bb}} </view>
```

**数据嵌套-循环**：复杂数循环：表格渲染

```JS
page.jsPage({
  data: {
    newlist:[
      {
        'catename':'国内新闻',
        list:[
          {'title':'这是国内新闻','id':'30'},
          {'title':'这是国内新闻','id':'40'},
          {'title':'这是国内新闻','id':'50'}
        ]
      },
      {
        'catename':'国际新闻',
        list:[
          {'title':'这是国际新闻','id':'30'},
          {'title':'这是国际新闻','id':'40'},
          {'title':'这是国际新闻','id':'50'}
        ]
      }
    ]
  }
})
```

```HTML
<view wx:for="{{newlist}}">
  <text>分类：{{item.catename}}</text>
  <text wx:for="{{item.list}}" wx:for-item="val">新闻：{{val.title}}</text>
</view>
```

#### 7.3.3 运算

WXML 可以执行简单的运算任务。例如：

```HTML
<view> {{a + b}} + {{c}} + d </view>
<view>{{"hello" + name}}</view> <!-- 也可以做到字符串拼接： -->
<!-- 甚至，你可以使用 ... 在 WXML 中展开对象。 -->
```

#### 7.3.4 模板`<template>`

[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxml/template.html)

WXML提供模板（template），可以在模板中定义代码片段，然后在不同的地方调用。
name 定义组件模版的名称，引用模版的时候使用 is 属性指定模版的名字，is 可以进行简单的三目运算，需要传入模版需要的 data 数据。

因为模版拥有自己的作用域，所以只能使用 data 传入数据，而不接受双花括号的写法。

```HTML
<template name="msgItem">
<view>
<text> {{index}}: {{msg}} </text>
<text> Time: {{time}} </text>
</view>
</template>
```

```HTML
<template is="msgItem" data="{{...item}}"/>
```

#### 7.3.5 公共模块的引用

WXML 提供 import 和 include 两种文件引用方式。

import 有作用域的概念，不能多重引用。

```HTML
<!-- B.wxml -->
<import src="a.wxml"/>
```

```HTML
<!-- A.wxml -->
<template name="A">
 <text> A template </text>
</template>
```

而 include 就可以多重引用了。

```HTML
<!--引用 header、其中 header.wxml 中也引用了 footer.wxml-->
<include src="header.wxml"/>
<view> body </view>
```

```HTML
<!-- header.wxml -->
<view> header </view>
<include src="footer.wxml"/>
```

#### 7.3.6 事件

[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxml/event.html)

在 WXML 中，可以使用 dataset 定义 data 中的数据，会通过事件传递。在 event 对象中
这些自定义属性：以 data- 开头，多个单词以 - 链接，如 data-a-b。
需要注意的是，使用这种方式定义的变量不能有大写。
它会自动转成驼峰命名，调取的时候去驼峰命名的名字。

什么是事件
事件是视图层到逻辑层的通讯方式。
事件可以将用户的行为反馈到逻辑层进行处理。
事件可以绑定在组件上，当达到触发事件，就会执行逻辑层中对应的事件处理函数。
事件对象可以携带额外信息，如 id, dataset, touches。

事件分类
事件分为冒泡事件和非冒泡事件：

冒泡事件：当一个组件上的事件被触发后，该事件会向父节点传递。
非冒泡事件：当一个组件上的事件被触发后，该事件不会向父节点传递。
bind 事件绑定不会阻止冒泡事件向上冒泡，catch 事件绑定可以阻止冒泡事件向上冒泡。

**WXML的可冒泡事件列表：**不希望他们冒泡的话就用 catch

|类型|触发条件|最低版本|
|:----|:----|:----|
|touchstart|手指触摸动作开始||
|touchmove|手指触摸后移动||
|touchcancel|手指触摸动作被打断，如来电提醒，弹窗||
|touchend|手指触摸动作结束||
|tap|手指触摸后马上离开||
|longpress|手指触摸后，超过 350ms 再离开，如果指定了事件回调函数并触发了这个事件，tap 事件将不被触发|1.5.0|
|longtap|手指触摸后，超过 350ms 再离开（推荐使用 longpress 事件代替）||
|transitionend|会在 WXSS transition 或 wx.createAnimation 动画结束后触发||
|animationstart|会在一个 WXSS animation 动画开始时触发||
|animationiteration|会在一个 WXSS animation 一次迭代结束时触发||
|animationend|会在一个 WXSS animation 动画完成时触发||
|touchforcechange|在支持 3D Touch 的 iPhone 设备，重按时会触发|1.9.90|

除了以上的事件，其他事件都是非冒泡的。

### 7.4 【wxss视图层】

[官网地址](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxss.html)

WXSS(WeiXin Style Sheets)是一套样式语言，用于描述 WXML 的组件样式。
WXSS 用来决定 WXML 的组件应该怎么显示。

为了适应广大的前端开发者，WXSS 具有 CSS 大部分特性。同时为了更适合开发微信小程序，WXSS 对 CSS 进行了扩充以及修改。
与 CSS 相比，WXSS 扩展的特性有：尺寸单位，样式导入

学习wxss之间需要也是需要熟知wxml组件。

需要注意的是 wxml 与 html 都是页面结构，但是 wxml 与html 是不一样的。
wxml 中可以使用div，p 等等，但是它们都变成了行内元素，不 display 改变属性的话，给他们设置宽高是没有用的。display:block。
除了div，p 其他的所哟块级元素都没有块级元素的性质。并且微信官网不建议这么使用。
并且在使用<div id="id11"></div>, wxss 不能使用 #id11 选择到。只能讲 view 替换 div。
因此既然做的是微信小程序就要跟着微信要求做，比较不容易出错。微信组件用最多的就是 view，text。这个 view 就是我们小程序的块级标签。

#### 7.4.1 选择器

|选择器|样例|样例描述|
|:----|:----|:----|
|.class|.intro|选择所有拥有 class="intro" 的组件|
|#id|#firstname|选择拥有 id="firstname" 的组件|
|element|view|选择所有 view 组件|
|element, element|view, checkbox|选择所有文档的 view 组件和所有的 checkbox 组件|
|::after|view::after|在 view 组件后边插入内容|
|::before|view::before|在 view 组件前边插入内容|

定义在 app.wxss 中的样式为全局样式，作用于每一个页面。在 page 的 wxss 文件中定义的样式为局部样式，只作用在对应的页面，并会覆盖 app.wxss 中相同的选择器。

```HTML
<!-- HTML -->
<text id="header"> header </test>
```

```WXSS
<!-- WXSS -->
#header::before{
  content:'this is'
}
```

```HTML
<!-- DOM,这里好像不对，实际情况再修改 -->
<text>this is<text/><text id="header"> header </test>
```

如果需要另起一行，可以在 wxss 中添加上 display:block;

#### 7.4.2 像素/尺寸单位rpx

[Github转换工具](http://allan5.com/px2rpx/)

尺寸单位
rpx（responsive pixel）: 可以根据屏幕宽度进行自适应。规定屏幕宽为 750rpx。如在 iPhone6 上，屏幕宽度为375px，共有 750 个物理像素，则 750rpx = 375px = 750 物理像素，1rpx = 0.5px = 1 物理像素。

|设备|rpx换算px (屏幕宽度/750)|px换算 rpx (750/屏幕宽度)|
|:----|:----|:----|
|iPhone5|1rpx = 0.42px|1px = 2.34rpx|
|iPhone6|1rpx = 0.5px|1px = 2rpx|
|iPhone6 Plus|1rpx = 0.552px|1px = 1.81rpx|

规定屏幕宽为 750rpx，这样不管什么设备上面设置了宽高为 rpx，都是相应的，不需要单独为每个设备单独设置 px 宽高。

#### 7.4.3 导入样式

@import "xxx.wxss"


## 一、本文记录开发小程序遇到的错误

避免bug

- 学习积累
- 文件名不要中文，包括图片名称，会有意想不到的错误发生
- 细心细心再细心，路径不要老出错
- 错误修改之后一定要保存，不保存运行调试还是错误的，会误以为没有修改正确

## 二、官方小程序开发工具MINA框架(快速启动模本)

###  2.1 app.json 文件

在设置全局配置的时候遇到错误，首页上实现底部选项卡 tabBar,容易出现错误如下：

- 1.文件路径出错
- 2.没有在pages上配置页面

#### 2.1.1 json 注释之后会出错，json 不能写注释

刚开始学习的时候我们希望在文件写上注释方便自己的理解，但是在 json 文件中，写//或者是/**/注释，都是不支持的。不仅是小程序，其他的问价的 json 文件都是不支持注释的，虽然网上有偏方写注释，那都违背 json 文件意愿啊。何必为了写注释增加代码的解析难度。

```JSON
//在代码中如下写这些代码都是错误的，代码无法得到正确的解析，使用的时候记得把注释删掉
"pages": [ //设置页面的路径
  "pages/index/index", //不需要写 index.wxml,index.js,index,wxss,框架会自动寻找并整合
  "pages/logs/logs"
],
"window": { //设置默认窗口的表现形式
  "navigationBarBackgroundColor": "#ffffff", //顶部导航栏背景色
  "navigationBarTextStyle": "black", //顶部导航文字的颜色 black/white
  "navigationBarTitleText": "微信接口功能演示", //顶部导航的显示文字
  "backgroundColor": "#eeeeee", //窗口的背景色
  "backgroundTextStyle": "light", //下拉背景字体、loading 图的样式，仅支持 dark/light
  "enablePullDownRefresh": false, //是否支持下拉刷新 ，不支持的话就直接不写！
  "disableScroll": true, //  设置true不能上下滚动，true/false，
  //注意！disableScroll 只能在 page.json 中有效，无法在 app.json 中设置该项。
}
```

**报错如下**

```JSON
Error: Expecting 'STRING','}', got INVALID
```

#### 2.1.2 设置的 pagePath 路径错误

tabBar 就是底部菜单切换，也就是切换页面，其实也就是 page

```JSON
"pages": [
    "pages/index/index",
    "pages/logs/logs",
    "pages/pomodoro/pommodoro"
  ],
  "tabBar": {
    "list": [
      {
        "pagePath": "'pages/logs/logs'", //这里错误，'pages/logs/logs' 没有在 pages 中出现
        "text": "日志"                   //这个路径其实就是 pages 里面路径直接复制下来就 ok 了
      },                                 //改为 "pagePath": "pages/logs/logs",
      {
        "pagePath": "pages/pomodoro/pommodoro",
        "text": "首页",
        "iconPath": "../img/a.png",
        "selectedIconPath": "../img/a.png"
      }
    ],
    "color": "#778899",
    "selectedColor": "#673ab7",
    "backgroundColor": "#2196f3",
    "borderStyle": "white",
    "position": "bottom"
  }
```

**错误**

```JSON
Error: tabBar[0].pagePath "'pages/index/index'" 需在 pages 数组中
tabBar[1].pagePath "'pages/logs/logs'" 需在 pages 数组中
```

#### 2.1.3 设置的 iconPath 路径错误

- 我们写的图片路径一定要正确，
- 图片名称不能是中文。

**错误**

```JSON
Error: tabBar.list[0].iconPath 文件不存在
tabBar.list[0].selectedIconPath 文件不存在
```

### 2.1.4 .json中颜色color的设置

**错误**
设置的文字颜色，背景颜色，用手机扫码调试无法展现

- ①backgroundTextStyle 与 borderStyle 都有固定的颜色，为颜色名称，使用的时候到官网查看。
- ②color 与 backgroundColor 还有 selectedColor，单词带有 color 的一定都用 rgb 格式来写，用颜色名称写的话，开发工具不会报错，但是用手机调试的时候就会发现用颜色名称，比如 red，gary，等等文字与背景都不会得到展示所需要的颜色。
- ③border-bottom: 1px solid #778899，边框的颜色也是 rgb 方式来写

在 wxss 中还是与 css 可以用名称来填写的。

### 2.1.5 导航问题API

- wx.navigateTo
- wx.redirectTo
- wx.switchTab  需要跳转的目标链接在 app.json 中的 tabbar 中选择这个方法
- wx.navigateBack
- wx.reLaunch

```JS
//链接错误，这样写才是对的，不要写后缀。
wx.switchTab({
  url: '../add/add' //这里是希望跳到add页面
})
```

①. wx.navigateTo(OBJECT)
—— 保留当前页面，跳转到应用内的某个页面，使用 wx.navigateBack 可以返回到原页面
②. wx.redirectTo(OBJECT)
—— 关闭当前页面，跳转到应用内的某个页面
③. wx.switchTab(OBJECT)
—— 跳转到 tabBar 页面，并关闭其他所有非 tabBar 页面

### 2.1.6 列表循环的问题

```TEXT
Now you can provide attr "wx:key" for a "wx:for" to improve performance.
```

是一个关于性能优化方面的提示.

wx:key
如果列表中项目的位置会动态改变或者有新的项目添加到列表中，并且希望列表中的项目保持自己的特征和状态（如 `<input/>`中的输入内容，`<switch/>` 的选中状态），需要使用 wx:key 来指定列表中项目的唯一的标识符。
wx:key 的值以两种形式提供

- 字符串，代表在 for 循环的 array 中 item 的某个 property，该 property 的值需要是列表中唯一的字符串或数字，且不能动态改变。
- 保留关键字 *this ,代表在 for 循环中的 item 本身，这种表示需要 item 本身是一个唯一的字符串或者数字，如：当数据改变触发渲染层重新渲染的时候，会校正带有 key 的组件，框架会确保他们被重新排序，而不是重新创建，以确保使组件保持自身的状态，并且提高列表渲染时的效率。如不提供 wx:key，会报一个 warning， 如果明确知道该列表是静态，或者不必关注其顺序，可以选择忽略。

如下将 wx:key 绑定数组中对象属性 unique，这个对象属性 unique 在数组中每一项保证是不一样的。

```HTML
<switch wx:for="{{objectArray}}" wx:key="unique" style="display: block;"> {{item.id}} </switch>
```

```JS
Page({
  data: {
    objectArray: [
      {id: 5, unique: 'unique_5'},
      {id: 4, unique: 'unique_4'},
      {id: 3, unique: 'unique_3'},
      {id: 2, unique: 'unique_2'},
      {id: 1, unique: 'unique_1'},
      {id: 0, unique: 'unique_0'},
    ]
  }
})
```

例如在做 todolist 的时候列表项的位置肯定会随着操作有改变的。wx：key 是必要的。

```html
<!-- 这里给它绑定的是每个事项的开始时间，开始时间使用的是 new Date 函数创建的，保证是不一样的 -->
view wx:for="{{m1.getTypeList(this.data.todolist)}}" wx:for-item="item" wx:key="startAt" class="weui-cell">
```

### 2.1.7  事件回调detail使用错误

```TEXT
detail is not defined;at pages/index/index page bindConfirm function
ReferenceError: detail is not defined
```

```JS
bindConfirm: function (e) {
    console.log(detail)//这里是错误的，detail 是事件参数 e 里面的属性，必须这样使用 console.log(e.detail)
    //构造待办列表对象
    var newTodo = {
      title: e.detail.value,
      isFinish: false,
      startAt: new Date()
    }
    this.data.todolist.push(newTodo)
    this.setData({
      inputvalue: '',
      todolist: this.data.todolist
    })
  }
 ```

### 2.7.1 重设data数据错误

page.js 文件中， data 对象中的数据是初始化的数据，后面需要修改数据的话，只能用 this.setData，不能直接给this.data.xxx 赋值，这样是不行的。并且需要注意的是，this.setData 中是键值名的形式出现的。有时候就需要构造key变量了。

```JS
data{
  name:'xiaomi',
  goods:[{id:1,name:'bag'}]
}
this.setData({
  name:'lm',
  goods:[{id:2,name:'cat'}]
  //goods[0].id:3  这样写是错误的
})
//key 不能用 this.data
```

```JS
wx.setStorage({
  key: 'todolist',
  data: this.data.todolist.join('')   //一定不要修改的值忘记写 this.data
})
```

这里少写 this.data，弄成 todolist.join('') 会报出下面的错误。因为它根本不知道 todolist 是什么东西

```TEXT
TypeError: Cannot read property 'join' of undefined
```

### 2.8.1 事件传参

在组件中可以定义数据，这些数据将会通过事件传递给 SERVICE。 书写方式： 以 data- 开头，多个单词由连字符-链接，不能有大写(大写会自动转成小写)如 data-element-type，最终在 event.target.dataset 中会将连字符转成驼峰 elementType。 所以不要使用连字符号

## 三、官方weui-wxss组件库

## 四、iview-weapp组件库

```TEXT
Error: wxml 编译错误，错误信息：./pages/index/index.wxml:36:9: expect end-tag `i-cell-group`., near `view`
```

出现这个错误是标签写错，开标浅语闭标签不匹配，一定要注意标签！！！