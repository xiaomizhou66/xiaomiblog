---
title: mpvue 框架 入门学习
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - mpvue 框架
abbrlink: e21bd181
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

已经学会了使用 vue.js 的话，小程序使用 mpvue 来做还是很简答的。

[Github：](https://github.com/Meituan-Dianping/mpvue)
[官网](http://mpvue.com/mpvue/)

### 1.1  wepy，mpvue，Taro，开发框架的差别

wepy：wepy-cli   基于 vue.js，但是有差异
mpvue：vue-cli   类   vue.js，但是有差异
Taro：taro-cli   基于 react.js

[差异学习网址](https://blog.csdn.net/qq_42564846/article/details/83147104)

## 二、mpvue.js 框架创建：vue-cli

因为 mpvue 是基于 vue.js 的，因为 mpvue 的框架其实也是使用 vue-cli 脚手架来搭建的。

在使用 vue-cli 之前，肯定是要保证电脑安装有 vue-cli 的。

### 2.1 vue-cli 脚手架工具的安装

```BASH
# 下面的步骤可以去看 vue-cli 文件夹下的文章
$ node -v  # v8.9.0  先检查下 Node.js 是否安装成功
$ npm -v # 5.6.0      先检查下 npm 是否安装成功
$ npm set registry https://registry.npm.taobao.org/ # 由于众所周知的原因，可以考虑切换源为 taobao 源
$ npm install --global vue-cli@2.9 # 一般是要 sudo 权限的 全局安装 vue-cli
```

前面 vue.js 的时候 web 端项目已经安装过 vue-cli 就不需要安装了。

### 2.2 vue-cli 脚手架创建项目

```BASH
# 创建一个基于 mpvue-quickstart 模板的新项目，注意这里使用的是  mpvue/mpvue-quickstart 不再是 web 项目的 webpack
# 它包含了 webpack 打包器
$ vue init mpvue/mpvue-quickstart my-project
# 注意这里就是复制这一句来操作的，不是有选项， / 这个代表什么？
# 这个过程 vue-cli 主要是先从远程的代码仓库中下载了一份注册名为 mpvue/mpvue-quickstart 的模板代码，
# 然后根据开发者在命令行提示过程中输入的信息，生成一份经过配置后的代码。
# 会提示说  Documentation can be found at http://mpvue.com  这个不是错
$ cd my-project
$ npm install  # 还原依赖，生成 node_moudules 文件夹
$ npm run dev
# 与 vue 项目一样，运行成功的回显之后，可以看到本地多了个 dist 目录，这个目录里就是生成的小程序相关代码。
```

### 2.3 vue-cli 脚手架项目  与 微信开发者工具 配合使用

与 官方提供的 wepy 框架一样，我们可以使用 vs-code ，webstorm 或者其他的工具来编辑代码，使用 开发者工具 打开 dist 这个与小程序相关的代码来实时查看编辑的效果。

小程序必须是使用开发者工具来调试的。它与 web ，移动端的区别。注意：开发者工具打开的是与小程序相关的代码，也就是 dist 文件夹中
.wxml  .wxss  .js  .json

[开发者工具下载网址](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)

```BASH
#使用开发者工具打开 dist 文件夹，进行调试
$ npm run dev # 新增的页面需要重新运行编译，因为开发者工具就是查看编译后 dist 中的代码
```

### 2.4 mpvue.js 框架 各个文件示意

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
├──config           # 配置文件夹
|  ├──dev.env.js    # 文件(生成)：
|  ├──index.js      # 文件(生成)：
|  └─ prod.env.js   # 文件(生成)：
|
├──dist             # 文件夹(生成)：编译生成的文件夹
|  └─ wx/  
|     ├──common/     # 文件夹(生成)：
|     ├──compoments/ # 文件夹(生成)：
|     ├─pages/        # 文件夹(生成)：
|     ├──app.js       # 文件(生成)：
|     ├──app.js.map   # 文件(生成)：
|     ├──app.json     # 文件(生成)
|     └─ app.wxss     #文件(生成)：
|
├──node_modules    # 文件夹(生成)：使用 npm 安装工具产生的文件夹（依赖包）
├──src             # 文件夹(生成)：原码存放
|  ├──components/  # 文件夹(生成)：组件存放
|  ├──pages/       # 文件夹(生成)：页面存放
|  ├──utils/       # 文件夹(生成)：
|  ├──app.json     # 文件(生成)：
|  ├──app.vue      # 文件(生成)：main.js 对应的 vue 组件
|  └──main.js      # 文件(生成)：入口 js 文件
|  
├──static          # 文件夹(生成)：
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
├──project.config.json # 文件(生成)：使用 yarn add 安装工具产生的文件  （项目配置文件）
└──README.md           # 文件(生成):手动创建的，项目说明文档
```

### 2.5 vue-cli 创建项目过程遇到的问题

#### 2.5.1 vue-template-compiler  的问题

```BBASH
λ cnpm install
| [48/53] Installing json-parse-better-errors@^1.0.1platform unsupported babel-loader@7.1.5 › webpack@3.12.0 › watchpack@1.6.0 › chokidar@2.
0.4 › fsevents@^1.2.2 Package require os(darwin) not compatible with your platform(win32)
[fsevents@^1.2.2] optional install error: Package require os(darwin) not compatible with your platform(win32)
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

## 三、生成的框架中各个文件的详细学习。

### 3.1 build & config 文件夹下的文件学习

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
```

### 3.2  src 文件夹的学习

```BASH
├──src             # 文件夹(生成)：原码存放
|  ├──components/  # 文件夹(生成)： 自定义组件
|  |   └──card.vue # 文件(生成)：   单文件组件
|  ├──pages/       # 文件夹(生成)：页面存放
|  |  ├── counter/ # vuex 演示页面
|  |  |  ├── index.vue # 页面模版 + 样式 + 逻辑
|  |  |  ├── main.js   # 入口文件, 配置 vue + 返回配置
|  |  |  └── store.js
|  |  ├── index/        # 首页
|  |  |  ├── index.vue
|  |  |  └── main.js
|  |  └── logs/         # 日志
|  |     ├── index.vue
|  |     ├── main.js
|  |     └── main.json
|  ├──utils/       # 文件夹(生成)：工具库
|  |   └── index.js
|  ├──app.json     # 文件(生成)：
|  ├──app.vue      # 文件(生成)：# app.wxss + app.js 生命周期使用 vue 组件
|  └──main.js      # 文件(生成)：入口 js 文件，export 的内容相当于 app.json
```

### 3.3 其他文件夹的学习

```BASH
├──static          # 文件夹(生成)：
|  └─.gitkeep        # 文件(生成)：
|  
├──.babelrc         # 文件(生成)：
├──.editorconfig    # 文件(生成)：
├──.eslintignore    # 文件(生成)：
├──.eslintrc.js     # 文件(生成)：
├──.gitignore       # 文件(生成)：上传 git 时忽略的文件/文件夹
├──.postcssrc.js    # 文件(生成)：
├──index.html          # 文件(生成):hmtl 源码文件，页面结构入口文件
├──package.json        # 文件(生成)：
├──project.config.json # 文件(生成)：
└──README.md           # 文件(生成):手动创建的，项目说明文档
```

### 3.4 完整项目的解析。

vue-cli 生成的框架是单页面框架，它的页面就是 根目录 下的 index.html 文件。也就是框架的 页面入口文件。
页面入口文件，对应的 js 动态语言文件在 src 文件夹根目录下的 main.js 文件。
main.js 文件对应的 组件为 app.vue 文件。

## 四、mpvue.js 的生命周期

mpvue 继承自 Vue.js，其技术规范和语法特点与 Vue.js 保持一致。

### 4.1 mpvue.js 框架原理

- mpvue 保留了 vue.runtime 核心方法，无缝继承了 Vue.js 的基础能力
- mpvue-template-compiler 提供了将 vue 的模板语法转换到小程序的 wxml 语法的能力
- 修改了 vue 的建构配置，使之构建出符合小程序项目结构的代码格式： json/wxml/wxss/js 文件

### 4.2 mpvue.js 生命周期

```JS
beforeCreate//在实例初始化之后，数据观测 (data observer) 和 event/watcher 事件配置之前被调用。

created     //在实例创建完成后被立即调用。实例已完成以下的配置：数据观测 (data observer)，属性和方法的运算，watch/event 事件回调。
            //然而，挂载阶段还没开始，$el 属性目前不可见。

beforeMount //在挂载开始之前被调用：相关的 render 函数首次被调用。

mounted
//小程序 onReady 后，才会触发这个周期函数 ，vue mounted 生命周期（el 被新创建的 vm.$el 替换，并挂载到实例上去之后调用该钩子。
//如果 root 实例挂载了一个文档内元素，当 mounted 被调用时 vm.$el 也在文档内。

beforeUpdate
//数据更新时调用，发生在虚拟 DOM 打补丁之前。这里适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。

updated
//由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。
//当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。
//然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用计算属性或 watcher 取而代之。

activated
//keep-alive 组件激活时调用。该钩子在服务器端渲染期间不被调用。

deactivated
//keep-alive 组件停用时调用。该钩子在服务器端渲染期间不被调用。

beforeDestroy
//实例销毁之前调用。在这一步，实例仍然完全可用。该钩子在服务器端渲染期间不被调用。

destroyed
//Vue 实例销毁后调用。调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。
//该钩子在服务器端渲染期间不被调用。
```

问题: vue.js 2.5+ 之后还有另外的周期函数，mpvue 是否支持？？？？？

继承 vue.js 的生命周期，稍微的做些改变，此外 mpvue.js 还加入了小程序的生命周期， 除特殊情况外，不建议使用小程序的生命周期钩子。？？？？？
[vue.js 生命周期](https://cn.vuejs.org/v2/api/#%E9%80%89%E9%A1%B9-%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F%E9%92%A9%E5%AD%90)
[小程序 APP.js 生命周期](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/app.html)
[小程序 pages.js 生命周期](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/page.html#%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F)

```JS
// app.js 的周期
onLaunch   //生命周期回调—监听小程序初始化 小程序初始化完成时（全局只触发一次）
onShow     //生命周期回调—监听小程序显示 小程序启动，或从后台进入前台显示时
onHide     //生命周期回调—监听小程序隐藏 小程序从前台进入后台时
onError    //错误监听函数	小程序发生脚本错误，或者 api 调用失败时触发，会带上错误信息
onPageNotFound  //页面不存在监听函数	小程序要打开的页面不存在时触发，会带上页面信息回调该函数
//其他        //Any 开发者可以添加任意的函数或数据到 Object 参数中，用 this 可以访问
```

```JS
// page.js 页面周期
data       //页面的初始数据
onLoad    //页面加载时触发。一个页面只会调用一次，可以在 onLoad 的参数中获取打开当前页面路径中的参数。
onShow    //页面显示/切入前台时触发。一个页面可以有很多次调用该函数。
onReady   //页面初次渲染完成时触发。一个页面只会调用一次，代表页面已经准备妥当，可以和视图层进行交互。
onHide     //页面隐藏/切入后台时触发。 如 navigateTo 或底部 tab 切换到其他页面，小程序切入后台等。可以摆调用多次
onUnload   //页面卸载时触发。如 redirectTo 或 navigateBack 到其他页面时。
onPullDownRefresh  //监听用户下拉动作
onReachBottom      //页面上拉触底事件的处理函数
onShareAppMessage  //用户点击右上角转发
onPageScroll       //页面滚动触发事件的处理函数
onResize           //页面尺寸改变时触发，详见 响应显示区域变化
onTabItemTap       //当前是 tab 页时，点击 tab 时触发
//其他         //Any 开发者可以添加任意的函数或数据到 Object 参数中，在页面的函数中用 this 可以访问
```

**注意点！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！**

1. 结合了 vue.js 的 10 个周期函数，还有 小程序的周期函数
2. vue.js 的 mouted 周期函数有所改变，是 on ready 之后
3. 有的文件内不建议使用某些 小程序的周期函数。

```JS
//app 部分：
onLaunch //初始化，小程序初始化完成时（全局只触发一次）
onShow  //当小程序启动，或从后台进入前台显示，小程序启动，或从后台进入前台显示时
onHide  //当小程序从前台进入后台，小程序从前台进入后台时

// page 部分：
onLoad  //监听页面加载
onShow  //监听页面显示
onReady //监听页面初次渲染完成
onHide  //监听页面隐藏
onUnload //监听页面卸载
onPullDownRefresh //监听用户下拉动作
onReachBottom    //页面上拉触底事件的处理函数
onShareAppMessage //用户点击右上角分享
onPageScroll    //页面滚动
onTabItemTap    // 当前是 tab 页时，点击 tab 时触发 （mpvue 0.0.16 支持）
```

问题：还有其他的周期函数是没有兼容么？

## 五、mpvue.js 模板语法

几乎全部支持 vue.js 的语法，但是有部分不能支持，以下是不能支持的部分。

- 支持 computed 计算属性
- 支持 v-if，v-else-if，v-else 条件渲染
- 支持 列表渲染，只是需要注意一点，嵌套列表渲染，必须指定不同的索引！

### 5.1 小程序里 不支持 v-html

小程序里所有的 BOM／DOM 都不能用，也就是说 v-html 指令不能用。

### 5.2 不支持部分复杂的 JavaScript 渲染表达式

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

### 5.3 不支持过滤器

渲染部分会转成 wxml ，wxml 不支持过滤器，所以这部分功能不支持。

### 5.4 不支持函数  methods 中的函数

不支持在 template 内使用 methods 中的函数。

### 5.5 样式不支持 对象

不支持 官方文档：Class 与 Style 绑定 中的 classObject 和 styleObject 语法。

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

### 5.6 暂不支持在组件上使用 Class 与 Style 绑定 ？？？？什么意思

### 5.7 列表渲染 li

```HTML
<!-- 嵌套列表渲染，必须指定不同的索引！
在这种嵌套循环的时候， index 和 itemIndex 这种索引是必须指定，且别名不能相同，正确的写法如下 -->
<template>
    <ul v-for="(card, index) in list">
        <li v-for="(item, itemIndex) in card">
            {{item.value}}
        </li>
    </ul>
</template>
```

### 5.8 事件处理器-几乎全支持