---
title: iview-ui【1】- 小白入门篇【记录一些使用的注意之处 & 自己经常犯的错】
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue.js 的 UI 组件库
abbrlink: 3b072484
updated:
tags:
comments:
---
## 一、前言

iView 是一套基于 Vue.js 的开源 UI 组件库，主要服务于 PC 界面的中后台产品。面向中后台业务的一整套前端解决方案，包含了工程构建、主题定制、多语言等功能，极大提升了开发效率。

官网：[网址](https://www.iviewui.com/components/form)。

使用的时候查阅官网即可，本文写一些注意的地方，以及自己经常犯的错。

## 二、安装

### 2.1  方法①：npm安装

```bash
  $ npm install iview --save
```

### 2.2 方法②：独立版本

```js
  <script type="text/javascript" src="iview.min.js"></script>
```

### 2.3 方法③：CDN安装

[CDN链接](https://www.bootcdn.cn/iview/)

```js
  <script src="https://cdn.bootcss.com/iview/2.14.0/iview.js"></script>
```

### 2.4 安装过程的坑

**坑1**

```BASH
λ cnpm install iveiw --save
× Install fail! Error: GET https://registry.npm.taobao.org/iveiw response 404 status
Error: GET https://registry.npm.taobao.org/iveiw response 404 status
    at get (C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\npminstall\lib\get.js:57:17)
    at get.next (<anonymous>)
    at onFulfilled (C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\co\index.js:65:19)
    at <anonymous>
    at process._tickCallback (internal/process/next_tick.js:188:7)
npminstall version: 3.10.0
npminstall args: C:\Program Files\nodejs\node.exe C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\npminstall\bin\install.js --fix-bug-versions --china --userconfig=C:\Users\Administrator\.cnpmrc --disturl=https://npm.taobao.org/mirrors/node --registry=https://registry.npm.taobao.org iveiw --save
```

**填坑**

**坑2**

```BASH
λ npm install iview --save
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-json-stable-stringify
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-deep-equal
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\pinkie-promise\node_modules\pinkie
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\pinkie-promise\node_modules
npm WARN request-promise-core@1.1.1 requires a peer of request@^2.34 but none is installed. You must install peer dependencies yourself.
npm WARN request-promise-native@1.0.5 requires a peer of request@^2.34 but none is installed. You must install peer dependencies yourself.

npm ERR! path F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-json-stable-stringify
npm ERR! code ENOENT
npm ERR! errno -4058
npm ERR! syscall access
npm ERR! enoent ENOENT: no such file or directory, access 'F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-json-stable-stringify'
npm ERR! enoent This is related to npm not being able to find a file.
npm ERR! enoent

npm ERR! A complete log of this run can be found in:
npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-08-21T07_18_57_459Z-debug.log
```

**填坑**

## 三、vue 项目中使用 iview-ui 组件引用方法

### 3.1 全局引用

官网中是使用 iview-cli 脚手架生成的，通常我是使用 vue-cli 脚手架来搭建框架的，因此  main.js 文件与 iview-ui 组件库的官网有出入， vue-cli 以下面的文件为准。

**步骤①：main.js 文件中引入**

```js
import Vue from 'vue'
import App from './App'
import router from './router'
import iView from 'iview'        //导入iview-ui
import 'iview/dist/styles/iview.css'//导入iview.css

Vue.config.productionTip = false

Vue.use(iView);     //全局使用iview

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
```

**步骤②：在 .vue 文件中使用 iview 组件**

### 3.2 按需引用

**步骤①：安装 babel-plugin-import 插件**

[babel-plugin-import插件挂网:](https://github.com/ant-design/babel-plugin-import)

```BASH
 npm install babel-plugin-import --save-dev
```

**步骤②：在文件 .babelrc 中配置：**

```JSON
// .babelrc
{
  "plugins": [["import", {
    "libraryName": "iview",
    "libraryDirectory": "src/components"
  }]]
}
```

**步骤③：在文件 .main.js 或者 APP.vue 文件引入样式：**

```JS
import 'iview/dist/styles/iview.css'; //按需引用还需要引如 css 样式
```

**步骤④：在 .vue 文件中使用 iview 组件**

## 四、iview-ui 组件使用规范

### 4.1 props 传参

使用 :prop 传递数据格式为 数字、布尔值或函数时，必须带 : (兼容 String 除外，具体看组件文档)，比如：

```HTML
<Page :current="1" :total="100">正确使用</Page>
<Page current="1" total="100">没有正确使用</Page>
```

### 4.2 非 template/render 模式下组件名要分隔

例如 DatePicker 必须要写成 date-picker

```HTML
<date-picker>正确使用</date-picker>
<DatePicker>没有正确使用</DatePicker>
```

### 4.3 非 template/render 以下组件加i-

- Button:&nbsp;&nbsp;&nbsp;i-button
- Col:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i-col
- Table:&nbsp;&nbsp;&nbsp;&nbsp;i-table
- Input: &nbsp;&nbsp;   i-input
- Form:  &nbsp; &nbsp;    i-form
- Menu:  &nbsp; &nbsp;    i-menu
- Select: &nbsp;    i-select
- Option: &nbsp;   i-option
- Progress:  i-progress
- Time: &nbsp;&nbsp;&nbsp;    i-time

### 4.4 (除非使用 iview-loader)其他任何情况 以下组件加i-

- Switch: i-switch
- Circle: i-circle

**什么是非 template/render模式？**
解析：

## 五、全局配置

使用 iView 3 时，可以进行全局配置组件的一些属性。

目前只支持配置 transfer 和 size 两个属性。组件会优先使用 prop 设置的属性，如果未设置，再使用全局配置。

transfer：所有带浮层的组件，是否将浮层放置在 body 内，默认为不设置，详见各组件默认的 transfer 值。可选值为 true 或 false。
size：所有带有 size 属性的组件的尺寸，默认为不设置，详见各组件默认的 size 值。可选值为 default、small 或 large。
用法如下：

**在 main.js 文件**

```JS
Vue.use(iView, {
    transfer: true,
    size: 'large'
});
```

## 六、国际化

### 6.1

### 6.2

## 七、定制主题

iView 默认提供了一套 UI 主题，并且可以在一定程度上定制新主题，以满足业务和品牌上的多样化视觉需求。

iView 的样式是基于 Less 进行开发的，默认以前缀 `.ivu-` 作为命名空间，并且定义了一套样式变量，定制主题，就是编辑这个变量列表。

**步骤①：创建如 `my-theme` 目录**

**步骤②：创建 index.less 文件**

```less
@import '~iview/src/styles/index.less';
// Here are the variables to cover, such as:
@primary-color: #8c0776;
```

完整的变量列表可以查看 [默认样式变量网址](https://github.com/iview/iview/blob/2.0/src/styles/custom.less)

**步骤③： main.js 中引入 index.less**

```JS
import Vue from 'vue';
import iView from 'iview';
import '../my-theme/index.less'; //引入 index.less 文件

Vue.use(iView);
```

**步骤④：修改 index.less 文件内容以修改主题颜色**

### 7.1 vue-cli 脚手架床架的项目中修改主题！！！


## 八、使用 iview-ui 组件示例：

### 8.1 巩固 vue-cli 理解

可以在：[vue-cli](http://liuxmoo.gofoer.com/2018/08/12/6-vue-cli1/)分类学习

- index.html 是项目入口文件，
- main.js 是 index.html 对应的 js 文件
    在 main.js 导入 vue，ui 组件， router 路由组件，路由 index.js 文件插件，组件的等等的引入
- APP.vue 就是 main.js 导入的第一个组件（所有 .vue 组件的终极父组件）

后续的页面设计与这 3 个根文件无关

- components 下的 .vue 设计子组件/各个页面的组件
- index.js 设置路由/各个子路由

### 8.2 使用 iveiw 组件的前期工作

在一个 vue-cli 脚手架创建好，且引入了 iveiw-ui 组件的项目。设计好页面，本文以主页为很路径页面。

- 将框架 src/components 下的 HelloWorld.vue 组件更名为 home.vue 组件。
- 相应的要在路由设置文件 index.js 文件中改写引入的组件/路由的设置

### 8.3 使用 iveiw 组件的布局

- 改写home.vue文件

## 九、使用 iveiw-ui 遇到的坑/自己犯的错

### 9.1 引入 iveiw 的出现 `import iView from '...iview'`，找不到模块

这个不是坑，`import iView from '...iview'`，既然是 import，它肯定需要导入的，需要时间，刚开始打开这个文件，会出现...，一会加载完，它就会好了。

### 9.1 使用 type 类型正确的坑

```HTML
vue.esm.js?efeb:591 [Vue warn]: Invalid prop: custom validator check failed for prop "type".

found in

---> <Button>
       <Content>
         <Layout>
           <HelloWorld> at src\components\home.vue
             <App> at src\App.vue
               <Root>
```

如上错误出现的话，说的是在 src\components\home.vue 这个 vue 文件中的 Button 组件在使用 type 使用错误。可能是编辑错误，字母刺写错了，还是多可空格等等其他符号啦。

示例：可能是想要个灰色的按钮，但是这个按钮的 type 是不能这样写的，不存在这个类型。

```HTML
 <Button
          type="disabled"
          shape="circle"
          @click="handleSelectAll(false)">取消全选
 </Button>
```

### `<Col>`改成`<i-col>`

```TEXT
 ✘  https://google.com/#q=vue%2Fno-parsing-error  Parsing error: x-invalid-end-tag
  src\components\pages\home.vue:13:11
            </Col>
             ^

  ✘  https://google.com/#q=vue%2Fno-parsing-error  Parsing error: x-invalid-end-tag
  src\components\pages\home.vue:14:32
            <Col span="12">col-12</Col>
                                  ^


✘ 2 problems (2 errors, 0 warnings)


Errors:
  2  https://google.com/#q=vue%2Fno-parsing-error

You may use special comments to disable some warnings.
Use // eslint-disable-next-line to ignore the next line.
Use /* eslint-disable */ to ignore all warnings in a file.
```

官网说明
在非 template/render 模式下（例如使用 CDN 引用时），组件名要分隔，例如 DatePicker 必须要写成 date-picker。
以下组件，在非 template/render 模式下，需要加前缀 i-：
Button: i-button
Col: i-col
Table: i-table
Input: i-input
Form: i-form
Menu: i-menu
Select: i-select
Option: i-option
Progress: i-progress
Time: i-time
以下组件，在所有模式下，必须加前缀 i-，除非使用 iview-loader：
Switch: i-switch
Circle: i-circle

### input组件样式修改

iview 框架中，不能使用 css 写样式直接修改，这里用到主题。iview 的样式是用 less 制作的，主题也可以使用less 变量来修改。iview中的网址：[git](https://github.com/iview/iview/blob/2.0/src/styles/custom.less)

在 vue-cli 框架中，用 webpack 创建的项目目录。node_modules→_iview@3.1.1@iview→src→styles 中是这个框架的样式这是文件，可以在这里看iview作者的代码设计，但是不要去改动 node_modules 文件夹的东西。


###  

```
TEXT
These dependencies were not found:

* iview in ./src/main.js
* iview/dist/styles/iview.css in ./src/main.js
* !!vue-style-loader!css-loader?{"sourceMap":true}!../../../node_modules/vue-loader/lib/style-compil
er/index?{"vue":true,"id":"data-v-5e4cad4c","scoped":true,"hasInlineConfig":false}!less-loader?{"sou
rceMap":true}!../../../node_modules/vue-loader/lib/selector?type=styles&index=0!./home.vue in ./src/
components/pages/home.vue

To install them, you can run: npm install --save iview iview/dist/styles/iview.css !!vue-style-loade
r!css-loader?{"sourceMap":true}!../../../node_modules/vue-loader/lib/style-compiler/index?{"vue":tru
e,"id":"data-v-5e4cad4c","scoped":true,"hasInlineConfig":false}!less-loader?{"sourceMap":true}!../..
/../node_modules/vue-loader/lib/selector?type=styles&index=0!./home.vue
```

``bash
npm install style-loader --save
```