---
title: 本地缓存之 同步缓存&&异步缓存
date: '2018/8/18 21:57:28'
categories:
  - 七、小程序
  - MINA 框架
abbrlink: 4a491eba
updated:
tags:
comments:
---

## 一、前言

Synchronize  翻译：同步。因此带有 sync 是同步的意思。
Asynchronize  翻译：不同步，异步。因此带有 async 是异步的意思。

以 Sync（同步，同时）结尾的都是都是同步缓存，二者的区别是，异步不会阻塞当前任务，同步缓存直到同步方法处理完才能继续往下执行。

## 二、小程序：数据缓存

[官方网址](https://developers.weixin.qq.com/miniprogram/dev/api/data.html#wxsetstorageobject)

- ①wx.setStorage：异步保存 key 的数据
- ②wx.setStorageSync：同步保存 key 的数据
- ③wx.getStorage：异步获取
- ④wx.getStorageSync：同步获取
- ⑥wx.getStorageInfo：异步获取当前 storage 的相关信息
- ⑦wx.getStorageInfoSync：同步获取当前 storage 的相关信：
- ⑧wx.removeStorage：异步移除指定 key
- ⑨wx.removeStorageSync：同步移除指定 key
- ⑩wx.clearStorage
- ⑪wx.clearStorageSync

### 2.1 同步与异步的选择？

举例说明一下，比如要请求用户信息的时候，需要从缓存中获取 iduser 这个变量，那只有获取到这个变量才能进行下一步。那就应该使用 wx.getStorageSync。这样能确保一定能获取到这个变量。这个时候就不能使用异步，我还没有获取到变量怎么进行下一步的工作。