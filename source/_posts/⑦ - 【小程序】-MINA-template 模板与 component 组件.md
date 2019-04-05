# template 模板与 component 组件

共同点：template 模块与 component 组件，是小程序中组件化的方式。
区别：
template 模块主要是 `展示`，方法需要在使用 template 的页面中定义。
component 组件，则拥有自己的 js 文件，整个 component 组件类似一个 page 页面。
简单来说，只是展示用，建议使用 template，组件中涉及到较多的逻辑，建议使用 component。

https://www.cnblogs.com/xyyt/p/9559326.html

# template 模块

小程序开发工具并不支持快速创建模板，因为它一个文件可以写多个模板，而且也只有 2 个文件。
template 模块：
      template.wxml 文件
      template.wxss 文件

```HTML
<!-- 定义模板 template.wxml -->

<!-- 一份文件中能写多个模板，用name区分 -->
<template name="easy">
  <text class='red' bindtap="click">I'm Easy,{{hello}}</text>
  <!-- 注意：1、这里有个点击事件。
            2、{{hello}}是使用模板时传入的属性（参数）
            其实这个就不建议使用 template 来做的 -->
</template>

<template name="Davi">
  <text>I'm Davi,nice to meet you</text>
  <!-- 这个只是展示用的，用 template 来做比较好 -->
</template>
```

```CSS
1 /* templates/demo/index.wxss */
2 .tempDemo{
3   width:100%;
4 }
5 view.tempDemo .name{color:darkorange}
```

```HTML
<!--pages.wxml-->
<!-- 导入模板 -->
<import src="../../template/template.wxml" />

<view class="container">
  <!-- 引用 template 模板，用 is="easy" 的方式，选择模板 -->
  <template is="easy"  data="{{...str}}" /><!-- data="{{...str}}" 传入参数，必须是对象 -->
  <template is="Davi" />
</view>
```

```CSS
/**pages.wxss**/
@import "../../template/template.wxss"; /* 引入 template 模板的样式 */
.container{
  display:flex;
}
```

```JS
//pages.js
// template 中没有 js 文件，因此 template 中的点击事件，在使用页面中的 js 里定义。
// 如上，name=easy 的模板有个点击事件 click，则 click方法，需要在 pages.js 中定义
// 因此有 js 操作的就不建议使用 template 模块了。尤其是及其复杂的交互操作的时候。
// 涉及到列表子项独立的操作，建议将列表子项写成 component。
Page({
  data: {
    str：{
      hello：”nice to meet you“
    }
  },
  // template 中的事件函数
  click:function(){
    console.log("click Easy");
  }
})
```

## component 组件

创建一个 component 快捷方式：
只能在微信开发者工具操作才能是快捷方式
创建一个 components 文件夹
在 component 目录下右键--新建--component，即可直接生成 4 个文件（json 中的设置会默认"component": true）。
一定要是在相应目录下右键新建，（如果点击 + 号创建就是在根目录下的文件，！！！删除还有点麻烦！！！）

component 组件的结构和 page 的结构类似，都是有 js、wxml、wxss、json 四类文件组成。代码与 page 是一样的。

- wxml 代码，与 page 一样，都是一样的写法
- js 代码，与 page 不同，快捷创建的方式都帮忙写好了的。 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
- json 代码，需要注明"component": true，表示这是一个组件

```HTML
<!--components/product/product.wxml-->
<text class="red" bindtap="click">component {{type}}  hello {{name}}</text>
```

```JS
// components/product/product.js
// 不止这些内容的~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~可以在微信官方文档去学习。
Component({
  /**
   * 组件的属性列表，使用组件时，传入的参数
   */
  properties: {
    name:{
      type:String,
      value:''
    }
  },

  /**
   * 组件的初始数据，组件内部的数据
   */
  data: {
    type:"组件"
  },

  /**
   * 组件的方法列表，组件内部的方法
   */
  methods: {
    click:function(){
      console.log("easy");
    }
  }
})
```

```JS
// components/product/product.json
{
  "component": true,
  "usingComponents": {}
}
```

```HTML
<!-- page.wxml -->
<!--index.wxml-->
<view class="container">
  <product name="Easy"/>
  <!-- 使用 product 组件，并传入值为 “Easy” 的 name 属性（参数） -->
</view>
```

```JSON
//index.json
{
  "usingComponents":{
    "hello":"/components/product/product"  //前面的 product 是组件名，可以更改。路径指向使用的组件
  }
}
```


需要跳到其他小程序，还需自己封装个组件。 ?????怎么做，后面学习



```bash
jsEnginScriptError
Component is not found in path "components/addrAddress/addrAddress" (using by "pages/addr/addr");onAppRoute
Error: Component is not found in path "components/addrAddress/addrAddress" (using by "pages/addr/addr")
    at e (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:844197)
    at e (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:844383)
    at http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:859578
    at Object.t.addView (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:860124)
    at Function.value (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:938528)
    at Ct (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:954268)
    at It (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:956388)
    at Function.<anonymous> (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:958295)
    at Nt.<anonymous> (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:931964)
    at Nt.emit (http://127.0.0.1:28026/appservice/__dev__/WAService.js:1:315230)
```

组件引入错误。但是怎么检查都不知道自己是哪里错了，这个组件原来的名称不是 addrAddress ，后面修改的，但是修改之后就错误了，是不是不能修改它的名字？一个bug ？总之没有找到为什么会显示说不对！