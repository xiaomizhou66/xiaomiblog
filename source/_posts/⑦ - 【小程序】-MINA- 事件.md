---
title: MINA 框架 事件
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - MINA 框架
updated:
tags:
comments:
---

## 一、前言

官网事件文档[地址](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxml/event.html)

## 二、事件类型选择

冒泡事件：当一个组件上的事件被触发后，该事件会向父节点传递。
非冒泡事件：当一个组件上的事件被触发后，该事件不会向父节点传递。

```BASH
# 冒泡事件列表

# touchstart        手指触摸动作开始
# touchmove         手指触摸后移动
# touchcancel       手指触摸动作被打断，如来电提醒，弹窗
# touchend          手指触摸动作结束
# tap               手指触摸后马上离开                                          // 通常都使用这个短暂的触屏事件
# longpress         手指触摸后，超过 350ms 再离开，如果指定了事件回调函数并触发了这个事件，tap 事件将不被触发
# longtap           手指触摸后，超过 350ms 再离开（推荐使用 longpress 事件代替)
# transitionend     会在 WXSS transition 或 wx.createAnimation 动画结束后触发
# animationstart    会在一个 WXSS animation 动画开始时触发
# animationiteration  会在一个 WXSS animation 一次迭代结束时触发
# animationend        会在一个 WXSS animation 动画完成时触发
# touchforcechange    在支持 3D Touch 的 iPhone 设备，重按时会触发
```

```BASH
# 非 冒泡事件列表（注：除上表之外的其他组件自定义事件如无特殊声明都是非冒泡事件）

# 如 <form/> 的 submit 事件，<input/> 的 input 事件，<scroll-view/> 的 scroll事件，(详见各个组件)
```

## 三、事件的使用方式

第 二 章中说明了事件类型，这里是事件的使用。

在事件名称前面加上 bind 或 catch 开头（bind 事件绑定不会阻止冒泡事件向上冒泡，catch 事件绑定可以阻止冒泡事件向上冒泡）非原生组件，还要加上冒号.

事件有冒泡阶段，还有捕获阶段。捕获阶段还要在 bind 或 catch 前面加上 capture-

例如，tap 事件，

bindtap 就是绑定 tap 事件。
catchtap 就是组织冒泡的 tap 事件。
bind:tap 非原生组件中使用事件还要这样用。其他用法与前面两个都是一样的。
capture-bind:tap

<view
  id="outer"
  bind:touchstart="handleTap1"
  capture-bind:touchstart="handleTap2"
>11</view>

## 3.1 普通事件 使用

### 3.1.1 传 定参

事件参数的传递方式 data-xxx

```HTML
<view id="tapTest" data-hi="WeChat" bindtap="tapName">Click me!</view>
```

```JS
const app = getApp()

Page({
  data:{
    //
  },
  onLoad() {
    //
  },
  onReady() {},
  onShow: function () {},
  tapName(event) {
    console.log(event)
  }
})
```

### 3.1. 2 传动态绑定的参数

## 3.2 WXS函数响应事件 使用

WXS 函数接受 2 个参数，第一个是 event，在原有的 event 的基础上加了 event.instance 对象，第二个参数是 ownerInstance，和 event.instance 一样是一个ComponentDescriptor 对象。

ownerInstance 包含了一些方法，可以设置组件的样式和 class，具体包含的方法以及为什么要用 WXS 函数响应事件，请点击[查看详情](https://developers.weixin.qq.com/miniprogram/dev/framework/view/interactive-animation.html)。

```HTML
<wxs module="wxs" src="./test.wxs"></wxs>
<view id="tapTest" data-hi="WeChat" bindtap="{{wxs.tapName}}">Click me!</view>
<!-- 注：绑定的WXS函数必须用 {{}} 括起来 -->
```

```JS
// test.wxs 文件实现 tapName 函数
function tapName(event, ownerInstance) {
  console.log('tap wechat', JSON.stringify(event))
}
module.exports = {
  tapName: tapName
}
```

## 3.3 event 对象 ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

```html
<view id="tapTest" data-hi="WeChat" bindtap="tapName">Click me!</view>
```

```JS
event =
{
  type: "tap",     // 1.事件类型
  timeStamp: 895,  // 2.事件生成时的时间戳，是 integer 类型的.(页面打开到触发事件所经过的毫秒数。!!!!!!!!)
                   //   int 与 integer 的区别从大的方面来说就是基本数据类型与其包装类的区别：Integer 是 int 的封装类；
                   //   int 是基本类型，直接存数值，而 integer 是对象，用一个引用指向这个对象
  target: {        // 3. 触发事件的组件的一些属性值集合,触发事件的源组件。  包括 id，tagName，dataset，  ？？？ tagname 怎么没有？？
    id: "tapTest",
    dataset: {
      hi: "WeChat"
    }
  },
  // 如果是 canvas 就没有这个对象
  currentTarget: { // 4. 当前组件的一些属性值集合，包括 id，tagName，dataset，  ？？？ tagname 怎么没有？？
    id: "tapTest", //    传递的数据都在 event.currentTarget.dataset 对象里面 ！！！！！！！事件源组件上由 data- 开头的自定义属性组成的集合
    dataset: {     //    4 与 3 不一定相同（捕获 与 冒泡），传参之后一定是要 currentTarget 里面的数据
      hi: "WeChat"
    }
  },
  detail: {        // 5. 额外的信息（自定义事件对象属性列表（继承 BaseEvent））
    x: 53,         //    自定义事件所携带的数据，如表单组件的提交事件会携带用户的输入，媒体的错误事件会携带错误信息，详见组件定义中各个事件的定义。
    y: 14          //    点击事件的 detail 带有的 x, y 同 pageX, pageY 代表距离文档左上角的距离。
  },
  touches: [       // 6. 触摸事件，当前停留在屏幕中的触摸点信息的数组（TouchEvent 触摸事件对象属性列表（继承 BaseEvent））
    {              //             touches 是一个数组，每个元素为一个 Touch 对象（canvas 触摸事件中携带的 touches 是 CanvasTouch 数组）。
                   //             表示当前停留在屏幕上的触摸点。
      identifier: 0, //  触摸点的标识符
      pageX: 53,     //  距离文档左上角的距离，文档的左上角为原点 ，横向为 X 轴，纵向为 Y 轴
      pageY: 14,
      clientX: 53,  //   距离页面可显示区域（屏幕除去导航条）左上角距离，横向为X轴，纵向为Y轴
      clientY: 14
    }
    // 如果是 canvas 的话，touches 对象如下
    //  {
    //     identifier: 0, //  触摸点的标识符
    //     x: 53,     //  距离 Canvas 左上角的距离，Canvas 的左上角为原点 ，横向为X轴，纵向为Y轴
    //     y: 14,
    //   }
  ],
  changedTouches: [ //7. 触摸事件，当前变化的触摸点信息的数组（TouchEvent 触摸事件对象属性列表（继承 BaseEvent））
    {               //            changedTouches 数据格式同 touches。 表示有变化的触摸点，如从无变有（touchstart），位置变化（touchmove），
      identifier: 0, //           从有变无（touchend、touchcancel）。
      pageX: 53,
      pageY: 14,
      clientX: 53,
      clientY: 14
    }
  ]
}
```

* 特殊事件： <canvas> 中的触摸事件不可冒泡，所以没有 currentTarget。
* target 和 currentTarget 区别开来
* dataset 规则

书写方式：
    以 data- 头，多个单词由连字符-链接，不能有大写(大写会自动转成小写)如 data-element-type，最终在 event.currentTarget.dataset 中会将连字符转成驼峰elementType。

```JS
<view data-alpha-beta="1" data-alphaBeta="2" bindtap="bindViewTap">
  DataSet Test
</view>
Page({
  bindViewTap(event) {
    event.currentTarget.dataset.alphaBeta === 1 // - 会转为驼峰写法
    event.currentTarget.dataset.alphabeta === 2 // 大写会转为小写
  }
})
```