---
title: 'vue 实战项目【5】--[仿网易云音乐 APP 端做 web 端]'
date: '2018/8/19 23:57:28'
categories:
  - ⑫ 综合实战项目
  - vue
updated:
tags:
comments:
---

## 一、前言

前面学习了 vue.js，已经学习它的框架 vue-cli，状态管理器 vuex，现在搭配一个 ui 框架 iview 来做一个项目：仿网易云音乐 APP 的 UI 界面做一个网易云音乐 web 端。

git 仓库：[网址]()

后端：[网址](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=neteasecloudmusicapi)，
用了git@github.com:Binaryify/NeteaseCloudMusicApi.git仓库提供的后端。

下面是为了让自己久不用会忘记做的一个项目编辑过程，方便自己后面查阅。

## 二、项目搭建vue-cli

### 2.1 搭建过程

搭建过程命令：[网址](https://liuxmoo.com/2018/08/29/6-vue-cli%20kuanjia-quanji/)，该文章中写的 cnpm，npm，请自行按照自己的实际情况选择使用。ui 组件库请按照自己的项目需要选择安装。

注意点：Eslint，vscode，vetur之间的冲突解决：[网址](https://liuxmoo.com/2018/08/20/13-others-vscode/),以及 console.log 调试的 ESlint 报错，都可以在这篇文章解决。

## 三、框架更新

### 3.1 更改项目以便 vscode，vetur，eslint 不冲突

【vscode】-编辑器默认格式化， ESlint 扩展格式化，vetur 扩展格式化，三者之间的冲突. [网址](https://liuxmoo.com/2018/08/20/13-others-vscode/),

- 更改框架中的eslintrc.js 文件，
- 设置好cscode配置项。

### 3.2 更改 build 文件夹下的 webpack.base.conf.js 以便使用 less

如果项目是需要使用 less 来写样式的话，就修改这个项目配置。在 module，rules 中添加如下

```JSON
 module: {
    rules: [
// 下面这里两个对象是自己添加的
      {
        test: /\.less$/,
        loader: "style-loader!css-loader!less-loader"
      },
      {
        test:/\.css$/,
        //loader:'css-loader!style-loader'
        loader:'style-loader'
      }
    ]
```

### 3.3 iview 主题修改

如果需要修改主题的可以做这步，iview-ui 官网：[地址](https://www.iviewui.com/docs/guide/theme)，我们做的就是 webpack 模式的项目，因此直接添加文件在 main.js 引入即可。

#### 3.3.1 主题修改的 less 文件引入的错误

```bash
 error  in ./my-theme/index.less
  Module build failed:
  // https://github.com/ant-design/ant-motion/issues/44
  .bezierEasingMixin();
  Inline JavaScript is not enabled. Is it set in your options?
      in F:\qianduan_dir\00program\web-vue\musiccloud\node_modules\_iview@3.1.3@iview\src\styles\color\bezierEasing.less (line 110, column 0)
  @ ./my-theme/index.less 4:14-250 13:3-17:5 14:22-258
  @ ./src/main.js
  @ multi ./node_modules/_webpack-dev-server@2.9.1@webpack-dev-server/client?http://localhost:8080 webpack/hot/dev-server ./src/main.js
```

这个没有解决！！！！！！！！！！！！！！！！不知道怎么用的。引如 less 就没法 run 了

### 3.4 最终的 index.html，main.js ， APP.vue ，router 下的 index.js

为了方便后续自己查阅，这就将所有依赖引入之后的代码挂在这里。

#### 3.4.1 index.html 中的更新

`<script src="//at.alicdn.com/t/font_848641_rz8h99j994g.js"></script>`这里是阿里字体图的网址引入方式，连接根据自己在阿里图标上的文件库地址更新修改。阿里图标的使用方法：[网址](http://www.iconfont.cn/help/detail?spm=a313x.7781069.1998910419.d8d11a391&helptype=code),这里我们使用的是第三种方法，在 style 中引入样式， .icon 然后再 .vue 中用标签 svg 来使用。

```HTML
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <script src="//at.alicdn.com/t/font_848641_rz8h99j994g.js"></script>
  <title>cloudmusic</title>
  <style type="text/css">
    .icon {
      width: 1em;
      height: 1em;
      vertical-align: -0.15em;
      fill: currentColor;
      overflow: hidden;
    }
/*     <svg class="icon" aria-hidden="true">
      <use xlink:href="#icon-wangyiyunyinle"></use>
    </svg> */
  </style>
</head>

<body>
  <div id="app"></div>
  <!-- built files will be auto injected -->
</body>

</html>
```

#### 3.4.2 main.js

```JS
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import iView from 'iview'    //导入 iview 组件库
import 'iview/dist/styles/iview.css'//导入 iview-ui 的样式
import './theme/index.less'   //导入修改的主题样式
import Vuex from 'vuex'         //导入vuex状态管理器
import store from '@/vuex/store'// 导入 store.js 文件
import axios from 'axios' //导入


// import './assets/styles/index'// 引入自定义的 less 文件
// 怎么引入才正确

Vue.use(iView)  //使用 iview
Vue.use(Vuex)  //使用 vuex

axios.defaults.baseURL = 'http://localhost:3000'// http://127.0.0.1:3000，项目后端默认路径设置
Vue.prototype.axios = axios
Vue.prototype.$massage = iView.Message
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,//注册路由
  store,//注册vuex
  components: { App },
  template: '<App/>'
})
```

#### 3.4.3 APP.vue

这个文件的 margin-top：60px。删掉的，其他的根据自己的需求修改或删除。

```HTML
<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
  /*  margin-top:60px; */
  }
  /* 我们样式的边距初始化可以卸载 APP.VUE 父组件中 */
  html,body{
    padding: 0;
    margin: 0;
  }
</style>
```

#### 3.4.4 router下的 index.js 路由设置

这个文件是路由设置，具体是根据自己项目页面来设置，这里是为了方便自己学习子路由设置记录的。具体路由设置学习这篇文章路由设置：[网址](https://liuxmoo.com/2018/08/12/7-vue-router-rumen/)。

先导入组件，然后为组件配置路由

```js
import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/pages/home'
import Homecontent from '@/components/pages/homecontent'
import Setting from '@/components/pages/setting'
import Musicdetail from '@/components/pages/musicdetail'
import Find from '@/components/pages/find'
import Personalfm from '@/components/pages/personalfm'
import Video from '@/components/pages/video'
import Friends from '@/components/pages/friends'
import Localmusic from '@/components/pages/localmusic'
import Load from '@/components/pages/load'
import Musicnet from '@/components/pages/musicnet'
import Musickeep from '@/components/pages/musickeep'
import Musiclikelist from '@/components/pages/musiclikelist'
import Musiclist from '@/components/pages/musiclist'

Vue.use(Router)

export default new Router({
  mode: 'history', //这里是取消网址中的#号
  routes: [
    {
      path: '/',
      component: Home,
      children: [
        {
          path: 'setting', name: 'Setting', component: Setting},
        {
          path: 'musicdetail', name: 'Musicdetail', component: Musicdetail},
        {
          path: '/',
          component: Homecontent,
          // 注意这里不要直接写 Content 路由， iview 组件库已经将它作为布局组件了
          // 不注意的话会出错啊，原来的布局组件被替换了，布局就会发生错误了。
          children: [
            {path: '/', name: 'Find', component: Find},
            {path: 'personalfm', name: 'Personalfm', component: Personalfm},
            {path: 'video', name: 'Video', component: Video},
            {path: 'friends', name: 'Friends', component: Friends},
            {path: 'localmusic', name: 'Localmusic', component: Localmusic},
            {path: 'load', name: 'Load', component: Load},
            {path: 'musicnet', name: 'Musicnet', component: Musicnet},
            {path: 'musickeep', name: 'Musickeep', component: Musickeep},
            {path: 'musiclikelist', name: ' Musiclikelist', component: Musiclikelist},
            {path: 'msiclist', name: ' Musiclist', component: Musiclist}]
        }]
    }]
})
```

## 四、项目开始编辑

### 4.1 布局

home 作为首页， *原来使用iview组件中的 `<Header><Content><Footer>`布局。*
但是实际上布局的话我们还是自己写比较好，组件库提供的布局我们还要去修改，很麻烦的，我们不知道 iview 背后是怎么做这个布局的话更麻烦，大框架布局还是我们自己写的好。

而且ui组件库提供的布局中：

- iview 中的 Header，Footer 为64px，自己修改所需。line-height 也不要忘记。
- 写了 header 与 footer，content 用 router-view 写子组件替换。

#### 4.1.1 基础布局

将 components 文件夹中创建两个文件夹，一个 pages 存放页面，一个 common 存放共有组件(非页面)。

框架中的 HelloWorld.vue 就是框架设置的首页， router 下 index.js 路由也可以知道，我们就在首页做基础布局。将 HelloWorld.vue 原有代码删除。改写为 Home.vue，当然也可以修改为 Index.vue 或者其他的，这里只是自己的取名，

**重要的是，这里.vue组件的名称每个单词的首字母都是大写的** ，就因为框架的是这样写的，就是去的 name 的对应名称，不因为什么，就是约定俗成，大家都好理解。

布局网址:[flex 与 calc 公式](https://liuxmoo.com/2018/08/14/2.2.1-css3-flex/)

#### 4.1.2 style编辑修改-scoped

scoped的学习：[vue-loader官网](https://vue-loader.vuejs.org/zh/guide/scoped-css.html#%E6%B7%B7%E7%94%A8%E6%9C%AC%E5%9C%B0%E5%92%8C%E5%85%A8%E5%B1%80%E6%A0%B7%E5%BC%8F)，[其他网址](https://www.cnblogs.com/zhuzhenwei918/p/6870340.html)

#### 4.1.3 style编辑修改-使用less

- ①安装less  `cnpm install less less-loader --save-dev`
    注意不要只安装 less，在 vue 中要用 less，还需要安装 less-loader
    --save-dev 表示编写时依赖这些环境但编译后运行时不再依赖
    这里用 cnpm，如果用 npm 可能会安装不成功
- ②vue-cli 脚手架 webpack 模式创建的项目不需要去修改配置。只需要第①步安装即可使用。如果不是 vue-cli 的 webpack 创建的，还需要以下的配置。

```JSON
//在 webpack.dev.conf.js 中，我们可以看到下面的代码：
  module: {
    rules: utils.styleLoaders({ sourceMap: config.dev.cssSourceMap })
  },
```

- ③ 在 .vue 中使用 less，开标签加上`lang="less"`即可
    已经在 webpack 中配置了，所以这里不需要引入任何 less 文件。
    在 style中 声明lang="less"。 注意： scoped 的作用仅仅是限定 css 的作用域，防止变量污染。

less 具体使用方法：[网址](https://liuxmoo.com/2018/09/30/20.1-less/)

```CSS
<style scoped lang="less">

</style>
```

#### 4.1.4 less 中使用 calc 公式

less 中使用 calc 公式与 css3 中是不一样的，因为 less 中有冲突，我们需要对公式进行相应的处理才行。[学习地址](https://liuxmoo.com/2018/09/30/20.2-less-calc/)







##  网站部署

### vue 项目 build 生成 dist 文件夹

```bash
$ npm run build 
```

使用 nginx 服务器 服务器部署网站：[nginx 服务器网站部署]()