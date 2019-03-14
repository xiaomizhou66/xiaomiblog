---
title: 小程序 MINA 框架 中遇到的 bug
date: '2018/8/19 23:57:28'
categories:
  - ⑮ bug 集合
  - 小程序 中遇到的 bug
updated:
tags:
comments:
---

# 一、前言

小程序 MINA 框架的问题。

# 二、各种问题

## 2.1 html 中 数据绑定的问题  数据绑定不能用复杂的括号，复杂了就识别不出来了

```html
<view class="product">
    <block wx:for="{{productsAll.products}}" wx:key="index">
        <view class="product-img">
        <!-- 这里的数组不要有括号 (item.images)[0].url,写成这样就错误了 -->
            <image src="{{item.images[0].url}}" style="width: 100px; height: 100px; background-color: #eeeeee;"></image>
        </view>
        <view class="product-name">
            <view class="title">{{item.name}}</view>
            <view class="title">{{item.price}}</view>
        </view>
    </block>
</view>
```

## 2.2 JS 中读取数据

```JS
 data: {
    productsRequest: {
        page: 1,
        size: 20
    }
 }
  
  this.data.productsRequest.page // 一定不要忘记 小程序中读取是 this.data.xxx，不要漏掉 data
```

## 2.3 `appLaunch with an already exist webviewId 131`

这个控制台的报错不知道是什么意思，总是时不时的会出现，一些 bug ，网上很多，官方也不知道是哪里的问题。这个问题总是冷不丁的就出来，它也没有影响小程序的执行，一会错误就自己没有了。

## 2.4 获取后端接口图片 404

http 中 ,404 就是路径错误的意思，在小程序也是一样的。

```BASH
VM111:5 Failed to load local image resource /pages/products/[object%20Object] the server responded with a status of 404 (HTTP/1.1 404 Not Found)
```

原因：
    1. 出现这种错误，通常是由于图片的路径不对而引起的。
        后端/外网 获取到的数据的话，就是获取不到对应的 url，url 层次确实没有错误的话就是 url 的字符串本身有问题
        本地的话，就是相对路径整错了，仔细看路径应该是怎么写的。
        有这么一种情况，如果图片路径被写在一个 A.js 文件里，而 B.js 文件引用了 A.js，
        此时 图片的路径 必须是相对于 B.js 的相对路径。建议最好在公共的 js 文件里使用绝对路径。？？？？看不懂
    2. 小程序后台管理的服务器地址是否设置正确？在开发者工具详情也可以看到设置的服务器域名的。

## 2.5 小程序如何快速创建页面文件？

通常我们如果是创建页面，就直接是在 pages 下面手动创建，但是这样有点麻烦。

解决方法：
    `快速创建四个文件的方法`。
    步骤：在 app.json 文件下 pages 数组里，添加一个页面的路径，
        如果这个路径指向的是一个不存在的文件，那么 MINA 框架会自动创建这个页面的四个文件。包含了基本的内容在里面的。
        用这种方式创建文件不仅快捷，而且页面文件会自动添加一些默认代码，防止出错。

## 2.6 循环的 key 问题, 以及其他问题

```BASH
“ Now you can provide attr "wx:key" for a "wx:for" to improve performance”
```

和 vue 类似的，循环要绑定一个 key 来使得唯一。。官方文档原话：如不提供 wx:key，会报一个 warning， 如果明确知道该列表是静态，或者不必关注其顺序，可以选择忽略。如果你一定想去掉这个警告，其实wx：key用来对列表渲染的数据指定一个"主键”，以加快列表渲染的速度。
所以使用循环的话一定不要忘记加上 wx:key="index"

题外：微信的循环
    默认 index，item 的名称，不需要像 vue 那样额外的指定。

>除了 item，index 可以直接使用之外，其他值还是从原来的值获取。

下面的 length 就是从原来的值获取的，因为 item 只是数组中的一项，肯定没有办法从这里获取 length 的啦，写代码多了也是晕乎。

```JS
<block wx:for="{{productData.images}}" wx:key="{{index}}">
    <swiper-item style="height: 750rpx">
        <image src="{{item.url}}" class="slide-image" width="750" height="750"/>
        <!-- style="width:750rpx;height:750rpx;"  image 标签页类似 img 标签，image 的 width="750" height="750" 是 rpx 单位的-->
        <text class="current">{{index+1}}/{{productData.images.length}}</text>
    </swiper-item>
</block>
```

## 2.7 数据类型不正确

```BASH
Error:page.json
“Expecting ‘String，‘Number，‘NULL，‘True....’”’’
```

这个错误的原因在于 page.json( 对应页面的 json 文件 )里没有加入{ }。即使 json 文件里没有任何内容，也需要加入一个{ }，作为默认代码。此外，json 文件不允许出现注释代码，如果有注释的代码，同样会报这个错误。

## 2.8 脚本错误或者未正确调用 Page（）

```BASH
Error:index.js
page is not a function
```

index.js (即对应页面的 js 文件)里，没有调用 Page 方法。即使 js 文件里没有任何代码，也需要在 js 里添加一个空的 Page（{ }）。注意 Page 的 P 要大写。

## 2.9 传值的时候 JSON.parse 错误

```BASH
# 直接按照上面的方法传值，就会发现有错误了，各种各样的错误
thirdScriptError
Unexpected end of JSON input;at "pages/buy/buy" page lifeCycleMethod onLoad function
SyntaxError: Unexpected end of JSON input


Unexpected token % in JSON at position 0;at "pages/buy/buy" page lifeCycleMethod onLoad function
SyntaxError: Unexpected token % in JSON at position 0

# 原因如下：
# 1. 看下 pages.json 文件，是不是有文件是空的？即使没有配置信息也不能让小程序的 json 文件为空
#    至少要有一堆花括号，所以就是在增加页面的时候要注意了，最直接的增加页面的方法是在 app.json 添加，
#    快速添加页面，增加速度，也避免错误。
# 2. json 文件是不是有注释了？json 文件不允许有注释
# 3. 传值的对象里面有特殊的字符，url 带参数，如果是对象，并且对象里面有特殊的字符，这些字符 JSON.parse
#    解析不了的，就会发生错误了
```

解决方法查看本文：[mima 框架传值]()