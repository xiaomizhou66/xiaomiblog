---
title: mpvue 框架 入门学习
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - mpvue 框架
updated:
tags:
comments:
---

## 一、前言

mpvue.js 是美团点评开源的一个使用 Vue.js 开发小程序的前端框架。框架基于 Vue.js 核心，mpvue 修改了 Vue.js 的  runtime 和  compiler 实现，使其可以运行在小程序环境中，从而为小程序开发引入了整套 Vue.js 开发体验。使用  mpvue 开发小程序，你将在小程序技术体系的基础上获取到这样一些能力：

彻底的组件化开发能力：提高代码复用性
完整的 Vue.js 开发体验
方便的 Vuex 数据管理方案：方便构建复杂应用
快捷的 webpack 构建机制：自定义构建策略、开发阶段 hotReload
支持使用 npm 外部依赖
使用 Vue.js 命令行工具 vue-cli 快速初始化项目
H5 代码转换编译成小程序目标代码的能力

[Github：](https://github.com/Meituan-Dianping/mpvue)
[官网](http://mpvue.com/mpvue/)

wepy：wepy-cli   基于 vue.js，但是有差异
mpvue：vue-cli   类   vue.js，但是有差异
Taro：taro-cli   基于 react.js
[差异学习网址](https://blog.csdn.net/qq_42564846/article/details/83147104)

## 二、mpvue.js 框架创建：vue-cli2

因为 mpvue 是基于 vue.js 的，因为 mpvue 的框架其实也是使用 vue-cli2 脚手架来搭建的。注意是 `vue-cli2` 目前（2019.04.04）还不支持 vue-cli3。

```BASH
# 1. 先检查下 Node.js 是否安装成功
$ node -v # v8.9.0
$ npm -v # 5.6.0  

# 2. 由于众所周知的原因，可以考虑切换源为 taobao 源
$ npm set registry https://registry.npm.taobao.org/

# 3. 全局安装 vue-cli2（一定要注意是安装 vue-cli2）
$ npm install --global vue-cli@2.9
$ npm install -g vue-cli@2.9


# 上面是准备工作 -------------------4-5-6-7 --------开发一个项目

# 4. 创建一个基于 mpvue-quickstart 模板的新项目，
# 注意这里使用的是  mpvue/mpvue-quickstart 不再是 web 项目的 webpack（它包含了 webpack 打包器）
# 注意这里就是复制这一句来操作的，不是有选项， / 这个代表什么？
# 这个过程 vue-cli 主要是先从远程的代码仓库中下载了一份注册名为 mpvue/mpvue-quickstart 的模板代码，
# 然后根据开发者在命令行提示过程中输入的信息，生成一份经过配置后的代码。
$ vue init mpvue/mpvue-quickstart my-project-name

# 5. cd 进入项目安装依赖
$ cd my-project

# 6.还原依赖
$ npm install   # 还原依赖，生成 node_moudules 文件夹
$ yarn install

# 7.运行项目
$ npm run dev
$ npm start
$ yarn start
# 与 vue 项目一样，运行成功的回显之后，可以看到本地多了个 dist 目录，这个目录里就是生成的小程序相关代码。


# 检查代码
$ npm run lint  #检查语法和格式
$ npm run lint -- --fix #检查代码语法和格式，并修复可自动修复的问题

# 8.打包上线，
# 用于生成发布用代码的，它会对代码进行一些压缩优化处理。
# 当小程序开发完成后，将要提交审核时，请使用 build 来生成发布的代码。
$ npm run build
$ yarn build
```

### 2.3 vue-cli 脚手架项目  与 微信开发者工具 配合使用

与 官方提供的 wepy 框架一样，我们可以使用 vs-code ，webstorm 或者其他的工具来编辑代码，使用 开发者工具 打开 dist 这个与小程序相关的代码来实时查看编辑的效果。

小程序必须是使用开发者工具来调试的。它与 web ，移动端的区别。注意：开发者工具打开的是与小程序相关的代码，也就是 dist 文件夹中
.wxml  .wxss  .js  .json

[开发者工具下载网址](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)

```BASH
# 使用开发者工具打开 dist 文件夹，进行调试
$ npm run dev # 新增的页面需要重新运行编译，因为开发者工具就是查看编译后 dist 中的代码
```

## 二、mpvue.js 框架 各个文件示意

[目录解释](https://www.jianshu.com/p/2e98cc166dbd)

```BASH
├──build                # 文件夹(生成)：编译功能文件
|  ├──build.js          # 文件(生成)：
|  ├──check-versions.js # 文件(生成)：
|  ├──dev-client.js     # 文件(生成)：
|  ├──dev-server.js     # 文件(生成)：
|  ├──utils.js          # 文件(生成)：
|  ├──vue-loader.conf.js       # 文件(生成)：
|  ├──webpack.base.conf.js     # 文件(生成)：
|  ├──webpack.dev.conf.js      # 文件(生成)：
|  └─ webpack.prod.conf.js     # 文件(生成)：
|
├──config           # 配置文件夹，用于开发和生产环境下的不同配置
|  ├──dev.env.js    # 文件(生成)：
|  ├──index.js      # 文件(生成)：
|  └─ prod.env.js   # 文件(生成)：
|
├──dist             # 文件夹(生成)：编译生成的文件夹
|  └─ wx/            #   --------------------------------------开发者工具打开的文件夹，应该是 wx 不是 dist！！！！！！！！！！！！！！
|     ├──common/     # 文件夹(生成)：
|     ├──compoments/ # 文件夹(生成)：
|     ├─pages/        # 文件夹(生成)：
|     ├──app.js       # 文件(生成)：
|     ├──app.js.map   # 文件(生成)：
|     ├──app.json     # 文件(生成)
|     └─ app.wxss     #文件(生成)：
|
├──node_modules    # 文件夹(生成)：使用 npm 安装工具产生的文件夹（依赖包）
├──src             # 文件夹(生成)：原码存放（开发者开发的文件夹---------------------------------------
|  ├──components/  # 文件夹(生成)：组件存放
|  |  ├──a.vue     #              组件 a
|  |  └──b.vue     #              组件 b
|  ├──pages/       # 文件夹(生成)：页面存放
|  |  ├──index     #              index 页面
|  |  |  ├──index.vue #           index 页面的 .vue 文件（必备）
|  |  |  ├──main.json #           index 页面的 .json 文件（可选）（index 页面的配置文件）
|  |  |  ├──store.js  #           状态管理文件           （可选）（每个页面下的内容都是一样的）
|  |  |  └──main.js   #           index 页面的 .js 文件 （必备）（每个页面的类似，也还可以添加其他的）
|  |  └──my
|  |  |  ├──index.vue #           my 页面的 .vue 文件（必备）
|  |  |  ├──main.json #           my 页面的 .json 文件（可选）（my 页面的配置文件）
|  |  |  ├──store.js  #           状态管理文件        （可选）（每个页面下的内容都是一样的）
|  |  |  └──main.js   #           my 页面的 .js 文件 （必备）（每个页面的类似，也还可以添加其他的）
|  ├──utils/       # 文件夹(生成)：可选文件夹
|  ├──app.json     # 文件(生成)：  这个与 mina 框架一下，就是小程序的全局配置文件
|  ├──app.vue      # 文件(生成)：入口 main.js 对应的 vue 组件------------------------------------- 入口.vue
|  └──main.js      # 文件(生成)：入口 js 文件-----------------------------------------------------入口 .js
|   # src 下可以新建一些文件夹，放置自己公用业务逻辑代码，比如说 http，request 请求啦，封装的 api 请求啦
|  
├──static          # 文件夹(生成)：静态文件（css，imgs 等）
|  └─.gitkeep        # 文件(生成)：
|  
├──.babelrc         # 文件(生成)：
├──.editorconfig    # 文件(生成)：
├──.eslintignore    # 文件(生成)：
├──.eslintrc.js     # 文件(生成)：
├──.gitignore       # 文件(生成)：上传 git 时忽略的文件/文件夹
├──.postcssrc.js    # 文件(生成)：
├──index.html          # 文件(生成):hmtl 源码文件，页面结构入口文件
├──package.json        # 文件(生成)：使用 yarn add 安装工具产生的文件  （项目配置文件）
├──project.config.json # 文件(生成)：使用 yarn add 安装工具产生的文件  （项目配置文件），
├                       #             用于管理微信开发者工具的小程序项目的配置文件，其中记录了小程序的appid、代码主目录、以及编译选项等等信息，
├                       #             在微信开发者工具中导入小程序项目的时候主要是通过该配置文件读取和写入配置信息。
└──README.md           # 文件(生成):手动创建的，项目说明文档
```

### 2.1 src

```BASH
├──src             # 文件夹(生成)：原码存放（开发者开发的文件夹---------------------------------------
|  ├──components/  # 文件夹(生成)：组件存放
|  |  ├──a.vue     #              组件 a
|  |  └──b.vue     #              组件 b
|  ├──pages/       # 文件夹(生成)：页面存放
|  |  ├──index     #              index 页面
|  |  |  ├──index.vue #           index 页面的 .vue 文件（必备）-----------------------------------注意每个页面的 .vue 都是 index.vue
|  |  |  ├──main.json #           index 页面的 .json 文件（可选）（index 页面的配置文件）----------注意每个页面的 .json 都是 main.json
|  |  |  ├──store.js  #           状态管理文件           （可选）（每个页面下的内容都是一样的）
|  |  |  └──main.js   #           index 页面的 .js 文件 （必备）（每个页面的类似，也还可以添加其他的）--注意每个页面的 .js 都是 main.js
|  |  └──my
|  |  |  ├──index.vue #           my 页面的 .vue 文件（必备）-----------------------------------注意每个页面的 .vue 都是 index.vue
|  |  |  ├──main.json #           my 页面的 .json 文件（可选）（my 页面的配置文件）---------------注意每个页面的 .json 都是 main.json
|  |  |  ├──store.js  #           状态管理文件        （可选）（每个页面下的内容都是一样的）
|  |  |  └──main.js   #           my 页面的 .js 文件 （必备）（每个页面的类似，也还可以添加其他的）--注意每个页面的 .js 都是 main.js
|  ├──utils/       # 文件夹(生成)：可选文件夹
|  ├──app.json     # 文件(生成)：  这个与 mina 框架一下，就是小程序的全局配置文件
|  ├──app.vue      # 文件(生成)：入口 main.js 对应的 vue 组件------------------------------------- 入口.vue
|  └──main.js      # 文件(生成)：入口 js 文件-----------------------------------------------------入口 .js
|   # src 下可以新建一些文件夹，放置自己公用业务逻辑代码，比如说 http，request 请求啦，封装的 api 请求啦
```

上面的解构看起来感觉会很复杂的，啰嗦。就是 pages 文件夹下，每个页面的文件有点复杂。
每个页面都是一个文件夹，
.vue 是必备的，
main.js 也是必备的，但是这个文件夹大致内容都是一致的，
store.js 也是内容都是一样的，这样的目录结构不是很友好。

因此我们会使用 mpvue-entry 来优化我们的项目目录。

## 三、 vue-cli2 创建项目过程遇到的问题

### 3.1 yarn/npm install 还原依赖出错

```BASH
λ `yarn install`
yarn install v1.13.0
info No lockfile found.
[1/5] Validating package.json...
[2/5] Resolving packages...
`warning css-loader > cssnano > autoprefixer > browserslist@1.7.7: Browserslist 2 could fail on reading Browserslist >3.0 config used in other tools.`
`warning css-loader > cssnano > postcss-merge-rules > browserslist@1.7.7: Browserslist 2 could fail on reading Browserslist >3.0 config used in other tools.`
`warning css-loader > cssnano > postcss-merge-rules > caniuse-api > browserslist@1.7.7: Browserslist 2 could fail on reading Browserslist >3.0 config used in other tools.`
`warning eslint > file-entry-cache > flat-cache > circular-json@0.3.3: CircularJSON is in maintenance only, flatted is its successor.`
`warning px2rpx-loader > px2rpx > fs-extra > graceful-fs@3.0.11: please upgrade to graceful-fs 4 for compatibility with current and future versions of Node.js`
`warning px2rpx-loader > px2rpx > fs-extra > graceful-fs > natives@1.1.6: This module relies on Node.js s internals and will break at some point.` Do not use it, and update to graceful-fs@4.x.
warning webpack-bundle-analyzer > bfj-node4@5.3.1: Switch to the `bfj` package for fixes and new features!

[3/5] Fetching packages...
info fsevents@1.2.7: The platform "win32" is incompatible with this module.
info "fsevents@1.2.7" is an optional dependency and failed compatibility check. Excluding it from installation.
[4/5] Linking dependencies...
warning "mpvue-loader > vue-loader@13.7.3" has unmet peer dependency "vue-template-compiler@^2.0.0".
# mpvue-loader 下的 vue-loader@13.7.3 需要的依赖 vue-template-compiler@^2.0.0 没有满足
[5/5] Building fresh packages...
success Saved lockfile.
Done in 23.87s.
```

### 3.2 vue-template-compiler  的问题

```BASH
λ cnpm install
`| [48/53] Installing json-parse-better-errors@^1.0.1platform unsupported babel-loader@7.1.5 › webpack@3.12.0 › watchpack@1.6.0 › chokidar@2.
0.4 › fsevents@^1.2.2 Package require os(darwin) not compatible with your platform(win32)`
`[fsevents@^1.2.2] optional install error: Package require os(darwin) not compatible with your platform(win32)`
√ Installed 53 packages
√ Linked 712 latest versions
√ Run 1 scripts
peerDependencies link ajv@5.5.2 in F:\qianduan_dir\00program\wechat-mpvue\suduku\node_modules\_ajv-keywords@2.1.1@ajv-keywords unmet with F:\qi
anduan_dir\00program\wechat-mpvue\suduku\node_modules\ajv(6.5.5)
peerDependencies WARNING mpvue-loader@1.1.4 › vue-loader@^13.0.4 requires a peer of vue-template-compiler@^2.0.0 but none was installed
deprecate px2rpx-loader@0.1.10 › px2rpx@0.5.3 › fs-extra@0.16.5 › graceful-fs@^3.0.5 please upgrade to graceful-fs 4 for compatibility with
current and future versions of Node.js
deprecate mpvue-loader@1.1.4 › css-loader@0.28.11 › cssnano@3.10.0 › autoprefixer@6.7.7 › browserslist@^1.7.6 Browserslist 2 could fail on
reading Browserslist >3.0 config used in other tools.
deprecate eslint@4.19.1 › file-entry-cache@2.0.0 › flat-cache@1.3.2 › circular-json@^0.3.1 CircularJSON is in maintenance only, flatted is i
ts successor.
deprecate webpack-bundle-analyzer@2.13.1 › bfj-node4@^5.2.0 Switch to the `bfj` package for fixes and new features!
Recently updated (since 2018-11-07): 10 packages (detail see file F:\qianduan_dir\00program\wechat-mpvue\suduku\node_modules\.recently_updates.
txt)
  Today:
    → mpvue-loader@1.1.4 › js-beautify@1.8.8 › editorconfig@0.15.2 › @types/node@^10.11.7(10.12.7) (03:12:26)
√ All packages installed (870 packages installed from npm registry, used 54s(network 49s), speed 293.69kB/s, json 765(7.51MB), tarball 6.55MB)
```

问题：还有一个没有安装，需要手动的选择版本来安装，`peerDependencies WARNING mpvue-loader@1.1.4 › vue-loader@^13.0.4 requires a peer of vue-template-compiler@^2.0.0 but none was installed` ：vue-template-compiler
解决：[vue.js git 解决网址](https://github.com/vuejs/vue-loader/issues/560)，虽然说试用 `npm i vue-template-compiler @^2.0.0--save-dev`
解决：[git 网址](https://github.com/vuejs/vue-loader/issues/1158)
解释：
默认情况下 vue-template-compiler 是作为 peerDependencies 的，也就是 npm install 的时候是不会自动安装的。在使用 vue 创建项目的时候就需要自己手动的安装。
为了保证跟 vue 版本完全一致啊，用 dependencies 是无法保证的，因为 vue 升级 vue-loader 不一定需要升级。

目前 vue-loader 使用时需要配置细节确实很多，诸如 vue-template-compiler 版本号这样的细节，最“傻瓜”且通用的方式毫无疑问就是直接通过 vue-cli 或最新的 @vue/cli 创建了。如果你留意过 vue-loader 文档的 Setting Up a Project 那一页的历史的话就更能体会了，包括你建议的 README 里也做了明确说明。但是小程序这里不是使用 vue-cli 创建的么？

#### 2.5.2 使用 微信开发者工具打不开 dist 文件夹的问题

微信开发者工具提示，请打开一个空目录，或者是含有 app.js ，app.json，app.wxss， 的文件夹。其实是因为，用官方创建的的象奴框架，生成的 dist 文件夹下面不是文件，而是一个 wx 文件夹，我们用开发者工具打开的时候，需要打开 dist 文件夹下的 wx 文件夹。

问题：为什么会还要个文件夹呢，这个不算是一个自我为难么？？？？

```BASH
├──dist             # 文件夹(生成)：编译生成的文件夹
|  └─ wx/  
|     ├──common/     # 文件夹(生成)：
|     ├──compoments/ # 文件夹(生成)：
|     ├─pages/        # 文件夹(生成)：
|     ├──app.js       # 文件(生成)：
|     ├──app.js.map   # 文件(生成)：
|     ├──app.json     # 文件(生成)
|     └─ app.wxss     #文件(生成)：
```


### 3.4 完整项目的解析。

vue-cli 生成的框架是单页面框架，它的页面就是 根目录 下的 index.html 文件。也就是框架的 页面入口文件。
页面入口文件，对应的 js 动态语言文件在 src 文件夹根目录下的 main.js 文件。
main.js 文件对应的 组件为 app.vue 文件。

## 四、app 入口，与 page 页面

### 4.1 app 入口

#### 4.1.1 app.vue  就是 mina 框架的 app.js  + app.wxss

[vue.js 生命周期](https://cn.vuejs.org/v2/api/#%E9%80%89%E9%A1%B9-%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F%E9%92%A9%E5%AD%90)
[小程序 APP.js 生命周期](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/app.html)
[小程序 pages.js 生命周期](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html#%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F)

1. 结合了 vue.js 的 10 个周期函数，还有 小程序的周期函数
2. vue.js 的 mouted 周期函数有所改变，是 onReady 之后
3. 有的文件内不建议使用某些 小程序的周期函数。

```HTML
<!-- app.vue -->

<script>
/* 这部分相当于原生小程序的 app.js */
export default {
  beforeCreate(){
    //在实例初始化之后，数据观测 (data observer) 和 event/watcher 事件配置之前被调用。
  },
  created () {
    //在实例创建完成后被立即调用。实例已完成以下的配置：数据观测 (data observer)，属性和方法的运算，watch/event 事件回调。
    //  然而，挂载阶段还没开始，$el 属性目前不可见。
    // 调用API从本地缓存中获取数据
    /*
     * 平台 api 差异的处理方式:  api 方法统一挂载到 mpvue 名称空间, 平台判断通过 mpvuePlatform 特征字符串
     * 微信：mpvue === wx, mpvuePlatform === 'wx'
     * 头条：mpvue === tt, mpvuePlatform === 'tt'
     * 百度：mpvue === swan, mpvuePlatform === 'swan'
     * 支付宝(蚂蚁)：mpvue === my, mpvuePlatform === 'my'
     */
    let logs
    if (mpvuePlatform === 'my') {
      logs = mpvue.getStorageSync({key: 'logs'}).data || []
      logs.unshift(Date.now())
      mpvue.setStorageSync({
        key: 'logs',
        data: logs
      })
    } else {
      logs = mpvue.getStorageSync('logs') || []
      logs.unshift(Date.now())
      mpvue.setStorageSync('logs', logs)
    }
  },
  beforeMount(){
    //在挂载开始之前被调用：相关的 render 函数首次被调用。
  },
  mounted(){
    //小程序 onReady 后，才会触发这个周期函数 ，vue mounted 生命周期（el 被新创建的 vm.$el 替换，并挂载到实例上去之后调用该钩子。
    //如果 root 实例挂载了一个文档内元素，当 mounted 被调用时 vm.$el 也在文档内。
  },
  beforeUpdate(){
      //数据更新时调用，发生在虚拟 DOM 打补丁之前。这里适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。
  },
  updated(){
    //由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。
    //当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。
    //然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用计算属性或 watcher 取而代之。
  },
  activated(){
      //keep-alive 组件激活时调用。该钩子在服务器端渲染期间不被调用。
  },
  deactivated(){
      //keep-alive 组件停用时调用。该钩子在服务器端渲染期间不被调用。
  },
  beforeDestroy(){
      //实例销毁之前调用。在这一步，实例仍然完全可用。该钩子在服务器端渲染期间不被调用。
  },
  destroyed(){
      //Vue 实例销毁后调用。调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。
    //该钩子在服务器端渲染期间不被调用。
  },
  //上面是与 vue.js 周期一样的周期，除特殊情况外，不建议使用小程序的生命周期钩子
  //下面是 小程序的周期，但是使用了 mpvue 框架之后不建议使用小程序的周期
  onLaunch(){},//初始化
  onShow(){}, //当小程序启动，或从后台进入前台显示
  onHide(){}, //当小程序从前台进入后台
  onError(){},   //错误监听函数,小程序发生脚本错误，或者 api 调用失败时触发，会带上错误信息,mpvue 没有提到这个，这个是没有么？？
  onPageNotFound(){},  //页面不存在监听函数	小程序要打开的页面不存在时触发，会带上页面信息回调该函数mpvue 没有提到这个，这个是没有么？？
  //其他        //Any 开发者可以添加任意的函数或数据到 Object 参数中，用 this 可以访问
  // 下面是自定义函数
  log () {
    console.log(`log at:${Date.now()}`)
  }
}
</script>

<style>
/* 这部分相当于原生小程序的 app.wxss */
.container {
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  padding: 200rpx 0;
  box-sizing: border-box;
}
</style>
```

#### 4.1.2 app.json 就是 mina 框架的 app.json

#### 4.1.3 src/main.js 下的 export 部分也可以写 app.json 配置

```JS
// 引入 app.vue 并创建 Vue 实例：
import Vue from 'vue'
import App from './App'

Vue.config.productionTip = false
App.mpType = 'app' //设置了一个 mpType 的属性值，其值为 app。
// 这个值是为了与后面要讲的小程序页面组件所区分开来，因为小程序页面组件和这个 App.vue 组件的写法和引入方式是一致的，为了区分两者，需要设置 mpType 值。

const app = new Vue(App)
app.$mount()

// export default {
//     // 这部分相当于原生小程序的 app.json
//        app.json 数据写在这里的话是 ok 的，但是没有必要
//     config: {
//       pages: [],
//       window: {
//         backgroundTextStyle: 'light',
//         navigationBarBackgroundColor: '#fff',
//         navigationBarTitleText: '第一个小程序',
//         navigationBarTextStyle: 'black'
//       }
//     }
//   }

```

### 4.2 page 页面

#### 4.2.1 page/index.vue

[vue.js 生命周期](https://cn.vuejs.org/v2/api/#%E9%80%89%E9%A1%B9-%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F%E9%92%A9%E5%AD%90)
[小程序 APP.js 生命周期](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/app.html)
[小程序 pages.js 生命周期](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html#%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F)

1. 结合了 vue.js 的 10 个周期函数，还有 小程序的周期函数
2. vue.js 的 mouted 周期函数有所改变，是 onReady 之后
3. 有的文件内不建议使用某些 小程序的周期函数。

index.vue 文件

1. 几乎完全是 vue.js 的写法
    scoped 局部样式、以及使用 HTML 标签来构建界面。这样最大化的保持和网页应用开发一致，减少了前端人员切换到小程序的学习理解成本，也为原先使用Vue开发的网页应用移植到小程序平台提供了降低迁移成本的可能。
2. 模板部分我们通常可以用 HTML 标签来写，比如 div、span 等，它们会在编译的时候被自动转换成小程序的原生组件view、text之类；
3. 而那些小程序特有的组件如 swiper、rich-text 等，可以直接在模板中使用。`可以使用小程序原生组件`
4. 哪些只能使用 button 来触发的呢？？？？？都还是只能使用按钮触发吧？？？？？？ mpvue 有做么？？？

```HTML
<template>
  <div class="my-warp">
    <p>
      <button @click="increment">+</button>
      <button @click="decrement">-</button>
    </p>
    <couter></couter>
    <couter-list></couter-list>
  </div>
</template>

<script>
// Use Vuex
import store from './store'
// 导入 a 组件
import couter from "@/components/couter";
import couterList from "@/components/couterList";
export default {
  data(){
    return{
        msg:''
    }
  },
  component:{
        couter,//注册 a 组件
        "couter-list":couterList//驼峰只能在 js 中使用，不要再 html 中用驼峰
  },
  beforeCreate(){},
  created(){},
  beforeMount(){},
  mounted(){},
  beforeUpdate(){},
  updated(){},
  activated(){},
  deactivated(){},
  beforeDestroy(){},
  destroyed(){},
  // 上面是 vue.js 的周期，建议使用上面的
  // 下面的周期是 小程序的周期，不建议使用
  onLoad(){},//监听页面加载
  onShow(){},//监听页面显示
  onReady(){},//监听页面初次渲染完成
  onHide(){},//监听页面隐藏
  onUnload(){},//监听页面卸载
  onPullDownRefresh(){},//监听用户下拉动作---------------------------特殊的功能，vue.js 是没有的，只能使用这个
  onReachBottom(){},//页面上拉触底事件的处理函数----------------------特殊的功能，vue.js 是没有的，只能使用这个
  onShareAppMessage(){},//用户点击右上角分享------------------------------------------这个可以使用
  onPageScroll(){},//页面滚动--------------------------------------------------------这个可以使用
  onTabItemTap(){}, //当前是 tab 页时，点击 tab 时触发 （mpvue 0.0.16 支持）-----------这个可以使用
  onResize(){},           //页面尺寸改变时触发，详见 响应显示区域变化？？？？mpvue 没有提到这个，是还不兼容么？
  computed: {
      // 计算属性
    count () {
      return store.state.count
    }
  },
  methods: {
      // 与 vue.js 不同的是，这里只能放置 @click 事件函数
      // 在模板中，除事件监听外，其余地方都不能调用methods下的函数
    increment () {
      store.commit('increment')
    },
    decrement () {
      store.commit('decrement')
    }
  }
}
</script>

<style>
.my-warp {
  text-align: center;
  margin-top: 100px;
}
</style>
```

#### 4.2.2 page/main.js

```JS
// 与 src/main.js 是不一样的
// 引入 index.vue 并创建 Vue 实例：
import Vue from 'vue'
import App from './index'

const app = new Vue(App)
app.$mount()

//export default {
// 这里其实就是 page/mian.json 文件，可以写在 page/main.js 文件里面，也可以单独一个文件出去
//  config: {
//    // 注意，页面级可配置属性相当于只是`src/main.js`中配置里的`window`部分
//    "navigationBarTitleText": "文章列表页面"
//  }
//}
```

## 五、注意问题

### 5.1 新建页面

直接复制 page 下的一个文件夹，`修改文件夹名称就好，文件名称不需要修改。`，新建文件，注意要重新运行 `npm run dev` 或者是 `yarn start` 或者 `npm start`。
编译器不会自动检测新加入的文件，实时编辑检测不到文件，那么 dist 文件夹就不会有我们新建的文件页面的。

### 5.2 模板语法

几乎全部支持 vue.js 的语法，但是有部分不能支持，以下是不能支持的部分。

- 支持 computed 计算属性
- 支持 v-if，v-else-if，v-else 条件渲染
- 支持 列表渲染，只是需要注意一点，嵌套列表渲染，必须指定不同的索引！

### 5.3 小程序里 不支持 v-html

小程序里所有的 BOM／DOM 都不能用，也就是说 v-html 指令不能用。

### 5.4 不支持部分复杂的 JavaScript 渲染表达式

原生 mina 框架中 html 就不知道复杂的 js 表达式，那么 mpvue 中也是一样的，也是不支持复杂的表达式的。

```HTML
<!-- 我们会把 template 中的 {{}} 双花括号的部分，直接编码到 wxml 文件中，由于微信小程序的能力限制(数据绑定)，所以无法支持复杂的 JavaScript 表达式。
目前可以使用的有 + - * % ?: ! == === > < [] .   剩下的还待完善。 -->

<!-- 这种就不支持，建议写 computed -->
<p>{{ message.split('').reverse().join('') }}</p>

<!-- 但写在 @event 里面的表达式是都支持的，因为这部分的计算放在了 vdom 里面 -->
<ul>
    <li v-for="item in list">
        <div @click="clickHandle(item, index, $event)">{{ item.value }}</p>
    </li>
</ul>
```

### 5.5 不支持过滤器

渲染部分会转成 wxml ，wxml 不支持过滤器，所以这部分功能不支持。

### 5.5 不支持函数  methods 中的函数

不支持在 template 内使用 methods 中的函数。

### 5.6 样式不支持 对象

不支持 官方文档：Class 与 Style 绑定 中的 classObject 和 styleObject 语法。三行表达式还是可以使用的。对象看起来也复杂就不要使用了。

```HTML
<!--  mpvue 中这样来写 -->
<!-- 为节约性能，我们将 Class 与 Style 的表达式通过 compiler 硬编码到 wxml 中，支持语法和转换效果如下： -->
<p :class="{ active: isActive }">111</p>
<p class="static" v-bind:class="{ active: isActive, 'text-danger': hasError }">222</p>
<p class="static" :class="[activeClass, errorClass]">333</p>
<p class="static" v-bind:class="[isActive ? activeClass : '', errorClass]">444</p>
<p class="static" v-bind:class="[{ active: isActive }, errorClass]">555</p>
<p v-bind:style="{ color: activeColor, fontSize: fontSize + 'px' }">666</p>
<p v-bind:style="[{ color: activeColor, fontSize: fontSize + 'px' }]">777</p>
```

```HTML
<!-- 还可以用 computed 方法生成 class 或者 style 字符串，插入到页面中
从性能考虑，建议不要过度依赖此。还是使用上面那样的办法就好了 -->
<template>
    <!-- 支持 -->
    <div class="container" :class="computedClassStr"></div>
    <div class="container" :class="{active: isActive}"></div>

    <!-- 不支持 -->
    <div class="container" :class="computedClassObject"></div>
</template>
<script>
    export default {
        data () {
            return {
                isActive: true
            }
        },
        computed: {
            computedClassStr () {
                return this.isActive ? 'active' : ''
            },
            computedClassObject () {
                return { active: this.isActive }
            }
        }
    }
</script>
```

### 5.8 暂不支持在组件上使用 Class 与 Style 绑定 ？？？？什么意思

### 5.7 列表渲染 li



### 5.8 事件处理器-几乎全支持