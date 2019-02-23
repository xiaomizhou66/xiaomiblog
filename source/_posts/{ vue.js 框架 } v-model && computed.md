---
title: 'vue--[ v-model && computed]'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---
## 一、前言

在使用到 v-model 与 computed 的时候可能会遇到这个错误。

提示错误，`Computed property "XXXXXX" was assigned to but it has no setter. `

## 二、错误原因

computed 属性选项中，
默认的都是 return ，也就是 get() 函数。在处理 data 中的数据使用没有问题。
但是在处理 v-model 的数据就会出现问题，v-model 的数据是用户输入的，如果直接用 get() 是获取不到真值的，做不到双向绑定。

在 data 获取的数据，他们就是 setter 了。
而 v-model 的数据需要在 computed 中添加 setter。只有return的话，是无法实现双向数据绑定的，要先将用户输入的数据 setter 进来。

```HTML
<div>
  <Slider
    v-model="newConfidence"
    show-input
    :min='0'
    :max='100'
    :tip-format="confidenceFormat"
  ></Slider>
  <div>{{num}}</div>
</div>
<script>
  data: () => ({
    confidence: 0.6,
    num:10
  }),
  computed: {
    newConfidence: {
      set(value) {
        this.confidence = value/100;
      },
      get() {
        return this.confidence * 100;
      }
    },
    newNum(){
      return this.num + '岁'
    }
  }
</script>
```