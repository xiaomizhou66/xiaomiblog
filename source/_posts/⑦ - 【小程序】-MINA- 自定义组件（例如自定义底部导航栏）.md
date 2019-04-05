---
title: MINA 框架 传值
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - MINA 框架
updated:
tags:
comments:
---

# 一、前言

自定义组件，可以让我们拓展自己的 UI 库，wxss-ui 也是这样来拓展出来的。

# 二、自定义组件 方法

微信官网自定义组件，[地址](https://developers.weixin.qq.com/miniprogram/dev/framework/custom-component/index.html)

```bash
# tabbarShlf.json 文件
{
  "component": true
}
```

```html
<!-- tabbarShlf.wxml 文件 -->
<view class="inner">
  {{innerText}}
</view>
<slot></slot>
```

```CSS
/* tabbarShlf.wxss 文件 */
/* 在组件 wxss 中不应使用 ID 选择器、属性选择器 和 标签名选择器。 */
.inner {
  color: red;
}
```

```JS
/* tabbarShlf.js 文件 */
Component({
  properties: {
    // 组件的对外属性，是属性名到属性设置的映射表，属性设置中可包含三个字段，
    // type 表示属性类型、 value 表示属性初始值、 observer
    // 表示属性值被更改时的响应函数属性值可以在组件使用时指定
    innerText: {
      type: String,
      value: 'default value',
    }
  },
  data: {
    //组件的内部数据，和 properties 一同用于组件的模板渲染
    someData: {}
  },
  observers:{
    //组件数据字段监听器，用于监听 properties 和 data 的变化
  },
  behaviors:''// string/array 类似于 mixins 和 traits 的组件间代码复用机制
  methods: {
    // 这里是一个自定义方法, 组件的方法，包括事件响应函数 和 任意的自定义方法，关于 事件响应函数 的使用
    // 组件的方法，其中下划线开头为私有方法
    customMethod() {}
  },

  // 组件的生命周期 写在 lifetimes 里面是新写法(推荐使用新的方法)，写在外面是旧写法
  // 组件的生命周期，指的是组件自身的一些函数，这些函数在特殊的时间点或遇到一些特殊的框架事件时被自动触发。
  lifetimes: {
    created(){
      // 组件实例刚刚被创建好时， created 生命周期被触发。！！！！！！！！！重点周期
      // 此时，组件数据 this.data 就是在 Component 构造器中定义的数据 data 。
      // 此时还不能调用 setData 。 通常情况下，这个生命周期只应该用于给组件 this 添加一些自定义属性字段。
    },
    attached() {
      // 在组件实例进入页面节点树时执行,！！！！！！！！！！！！！！！！！！重点周期
      // 在组件完全初始化完毕、进入页面节点树后， attached 生命周期被触发。
      // 此时， this.data 已被初始化为组件的当前值。这个生命周期很有用，绝大多数初始化工作可以在这个时机进行。
    },
    ready:()=>{
      //组件生命周期函数，在组件布局完成后执行，
    },
    moved:()=>{
      //组件生命周期函数，在组件实例被移动到节点树另一个位置时执行
    },
    detached() {
      // 在组件实例被从页面节点树移除时执行,！！！！！！！！！！！！！！！！！！重点周期
      // 在组件离开页面节点树后， detached 生命周期被触发。
      // 退出一个页面时，如果组件还在页面节点树中，则 detached 会被触发。
    },
  },
  // 以下是旧式的定义方式，可以保持对 <2.2.3 版本基础库的兼容
  attached() {
    // 在组件实例进入页面节点树时执行
  },
  detached() {
    // 在组件实例被从页面节点树移除时执行
  },


  // 组件所在页面的生命周期,还有一些特殊的生命周期，它们并非与组件有很强的关联，但有时组件需要获知，以便组件内部处理。这样的生命周期称为“组件所在页面的生命周期”，在 pageLifetimes 定义段中定义。其中可用的生命周期包括：
  pageLifetimes: {
    show() {
      // 页面被展示
    },
    hide() {
      // 页面被隐藏
    },
    resize(size) {
      // 页面尺寸变化
    }
  },
  relations:{
    //组件间关系定义
  },
  externalClasses:'',// string / array 组件接受的外部样式类
  options:{
     innerText: {
      type: String,
      value: 'default value',
    }
  },
  definitionFilter:()=>{

  },
})
```

```JS
// page.josn
{
  "usingComponents": {
    "component-tag-name": "path/to/the/custom/component" // 这里根据自己的路径去修改
  }
}
```

```HTML
<!-- 在页面的 wxml 中就可以像使用基础组件一样使用自定义组件。
节点名即自定义组件的标签名，节点属性即传递给组件的属性值。 -->

<!-- page.wxml -->
<view>
  <!-- 以下是对一个自定义组件的引用 -->
  <component-tag-name inner-text="Some text"></component-tag-name>
</view>
```

# 三、自定义组件 细节注意事项

一些需要注意的细节：

- 因为 WXML 节点标签名只能是`小写字母`、`中划线`和`下划线`的组合，所以自定义组件的标签名也只能包含这些字符。
- 自定义组件也是可以引用自定义组件的，引用方法类似于页面引用自定义组件的方式（使用 usingComponents 字段）。
- 自定义组件和页面所在项目根目录名不能以“wx-”为前缀，否则会报错。

注意，是否在页面文件中使用 usingComponents 会使得页面的 this 对象的原型稍有差异，包括：

- 使用 usingComponents 页面的原型与不使用时不一致，即 Object.getPrototypeOf(this) 结果不同。
- 使用 usingComponents 时会多一些方法，如 selectComponent 。
- 出于性能考虑，使用 usingComponents 时， setData 内容不会被直接深复制，即 this.setData({ field: obj }) 后    this.data.field === obj 。（深复制会在这个值被组件间传递时发生。）
- 如果页面比较复杂，新增或删除 usingComponents 定义段时建议重新测试一下。

# 四、 自定义底部导航

```bash
# tabbarShlf.json 文件
{
  "component": true
}
```

```html
<!-- tabbarShlf.wxml 文件 -->
<view class="inner">
  {{innerText}}
</view>
<slot></slot>
```

```CSS
/* tabbarShlf.wxss 文件 */
/* 在组件 wxss 中不应使用 ID 选择器、属性选择器 和 标签名选择器。 */
.inner {
  color: red;
}
```

```JS
/* tabbarShlf.js 文件 */
Component({
  properties: {
    // 这里定义了innerText属性，属性值可以在组件使用时指定
    innerText: {
      type: String,
      value: 'default value',
    }
  },
  data: {
    // 这里是一些组件内部数据
    someData: {}
  },
  methods: {
    // 这里是一个自定义方法
    customMethod() {}
  }
})
```

```JS
// page.josn
{
  "usingComponents": {
    "component-tag-name": "path/to/the/custom/component" // 这里根据自己的路径去修改
  }
}
```

```HTML
<!-- 在页面的 wxml 中就可以像使用基础组件一样使用自定义组件。
节点名即自定义组件的标签名，节点属性即传递给组件的属性值。 -->

<!-- page.wxml -->
<view>
  <!-- 以下是对一个自定义组件的引用 -->
  <component-tag-name inner-text="Some text"></component-tag-name>
</view>
```