---
title: eCharts-ui 与 v-charts【1】- 图表组件库
date: '2018/8/19 23:57:28'
tags:
  - v-charts 图标库
categories:
  - ④  vue.js
  - vue.js 的 UI 组件库
updated:
comments:
---
## 一、图表组件库

在使用 echarts 生成图表时，经常需要做繁琐的数据类型转化、修改复杂的配置项，v-charts 的出现正是为了解决这个痛点。基于 Vue2.0 和 echarts 封装的 v-charts 图表组件，只需要统一提供一种对前后端都友好的数据格式设置简单的配置项，便可轻松生成常见的图表。

eCharts  是基础
v-charts 是基于 Vue2.0 和 echarts 封装，更方便我们使用于 vue 项目中。

[eCharts 官网文档](http://echarts.baidu.com/tutorial.html#5%20%E5%88%86%E9%92%9F%E4%B8%8A%E6%89%8B%20ECharts)
[v-charts 官网文档](https://v-charts.js.org/#/)

## 二、安装

### 2.1  echarts 安装引入

```bash
$ npm install echarts --save
#
```

npm 的方法还需要导入

[导入](http://echarts.baidu.com/tutorial.html#%E5%9C%A8%20webpack%20%E4%B8%AD%E4%BD%BF%E7%94%A8%20ECharts)

### 2.2 v-charts 的安装引入（vue 项目就直接使用这个吧!!!!!!!!!!!!!!!!!!!!）

#### 2.2.1 安装

```BASH
$ npm i v-charts echarts -S
```

#### 2.2.2 完全导入

```JS
// main.js  完全导入
import Vue from 'vue'
import VCharts from 'v-charts'
import App from './App.vue'

Vue.use(VCharts)

new Vue({
  el: '#app',
  render: h => h(App)
})
```

#### 2.2.3 按需导入

```BASH
# v-charts/lib 文件夹下 有的每种图表组件，都单独打包好了
|- lib/
    |- line.common.js  -------------- 折线图
    |- bar.common.js  --------------- 条形图
    |- histogram.common.js  --------- 柱状图
    |- pie.common.js  --------------- 饼图
    |- ring.common.js  -------------- 环图
    |- funnel.common.js  ------------ 漏斗图
```

```JS
// v-charts/lib 文件夹下 有的每种图表组件，都单独打包好了 使用的时候，我们只需要单独的引入就 ok
import Vue from 'vue'
import VeLine from 'v-charts/lib/line.common'// 例如现在需要使用 line 图表
import App from './App.vue'

Vue.component(VeLine.name, VeLine)

new Vue({
  el: '#app',
  render: h => h(App)
})
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