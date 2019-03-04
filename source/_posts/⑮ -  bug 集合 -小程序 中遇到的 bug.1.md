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

# 二、 

## 2.1 html 中 数据绑定的问题

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