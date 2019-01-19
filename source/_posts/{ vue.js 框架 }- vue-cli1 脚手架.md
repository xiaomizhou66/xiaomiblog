---
title: 'vue-cli1--[小白入门篇、速学篇]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue-cli 脚手架
abbrlink: cd55770d
updated:
tags:
comments:
---
## 一、前言

学习了 vue.js,vue-cli,vue-router,axios,element-ui,lodash.js 或者其他等等框架。

Vue CLI 是一个 Vue.js 快速开发的完整系统， 搭建交互式项目脚手架。
Vue CLI 致力于将 Vue 生态中的工具基础标准化。它确保了各种构建工具能够基于智能的默认配置即可平稳衔接，这样你可以专注在撰写你的应用上，而不必花好几天去纠结配置的问题。与此同时，它也为每个工具提供了调整配置的灵活性，无需跳出。不需要我们花时间去创建各种文件夹。

- 通过 @vue/cli 搭建交互式项目脚手架。
- 通过 @vue/cli + @vue/cli-service-global 快速创建零配置原型。
- 一个运行时依赖 (@vue/cli-service)，该依赖：
- 可升级；
- 基于 webpack 构建，并带有智能的默认配置；
- 可以通过项目内的配置文件进行配置；
- 可以通过插件进行扩展。
- 一个丰富的官方插件集合，集成了前端生态中最好的工具。

## 二、环境准备：应用的安装

仅为 windows 系统 npm 安装方法

## 2.1全局安装 node.js

```BASH
# 安装 node.js，命令行输入 node -v 查看版本来测试是否成功安装
① 中文地址：http://nodejs.cn/download/
② 英文地址：https://nodejs.org/en/download/
③ 历史版本下载地址：https://nodejs.org/dist/
④ 全面的详解安装方法：http://www.runoob.com/nodejs/nodejs-install-setup.html
```

## 2.2全局安装 npm

```BASH
# 新版本的 node.js 中已经含有 NPM，如果是新版本不需要再安装 NPM，
# 安装NPM， 命令行输入 `npm -v` 查看版本来测试是否成功安装
# 全面的详解安装方法：http://www.runoob.com/nodejs/nodejs-npm.html
```

## 2.3全局安装 cnpm

```BASH
$ npm install -g cnpm --registry=https://registry.npm.taobao.org # 安装 cnpm
# 安装 CNPM，可以使用 `cnpm-v` 查看版本来测试是否成功安装
```

## 2.4 全局安装 pnpm

```BASH
# install pnpm
$ npm install -g pnpm # pnpm 是先使用缓存，要比 npm 要好一点
```

### 2.4升级NPM版本

```BASH
# 升级 npm 版本，命令行输入
$ npm install npm -g ，或者是淘宝镜像
$ cnpm install npm -g
```

### 2.5 vue 安装

```BASH
$ cnpm install vue --g
# 全局安装 vue.js
```

### 2.6 vue-cli 安装（包括 vue-router）

```BASH
$ npm install vue-cli -g  # 或者是 cnpm，pnpm 全局安装 vue.js
$ vue -V                  # 查看版本，疑问，这个是查 vue-cli 的版本？？？vue 的版本呢？？
                        #（注意这个 V 是大写的，否则错误，查不到版本）
```

### 2.7 安装 Vue Devtools 调试工具

    以上为 npm 的安装，下面开始使用 vue 创建项目
    https://github.com/vuejs/vue-devtools#vue-devtools 安装 Vue Devtools 调试工具

## 三、初始化项目：vue 项目构建完整构建过程

### 3.1 完整的创建项目过程

#### 3.1.1 webpack 模板名称

创建项目之前先知道一下模板名称，vue-cli 官方为我们提供了 5 种模板：**一般情况下，都是用 webpack 模板**

```BASH
#  webpack:  一个全面的 webpack+vue-loader 的模板，功能包括热加载，linting 检测和 CSS 扩展。
#  webpack-simple  一个简单 webpack+vue-loader 的模板，不包含其他功能，让你快速的搭建vue的开发环境。
#  browserify：一个全面的 Browserify+vueify 的模板，功能包括热加载，linting,单元检测。
#  browserify-simple:一个简单 Browserify+vueify 的模板，不包含其他功能，让你快速的搭建 vue 的开发环境。
#  simple:一个最简单的单页应用模板。
```

#### 3.1.2 vue 框架项目创建    JavaScript 项目 JavaScript 项目 JavaScript 项目!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

```bash
# -S 表示 --save
# i  表示 install


$ vue init webpack  projectname  # 创建 vue 项目
$ cd  projectname  # 进入到项目目录
$ cnpm install  # 下载 vue 依赖包
$ cnpm run dev  # 获取访问端口：http://localhost:8080/,开发过程调试等工作
# http://0.0.0.0:4000  如果运行后得到的网址是这个，直接复制这个是打开是不行的，
# 127.0.0.1:4000 要换成这个去运行， 0.0.0.0  是没有的，
# 还不行的话，多试几遍，再是不行的话，看看是不是同时有别的的项目在运行，用了 4000 这个端口。

# 经过几次的项目创建，发现没有 run 之前安装 vuex ， ui 组件这些都没有成功，
# 非是要 run 之后再来安装这些依赖包，方可使用。所以还是先 run 一下，再安装下面的安装包吧。


$ cnpm install vuex          #下载 vuex 状态管理器（状态就是某种条件状态下的数据保存起来），
$ cnpm iinstall element-ui --save # 下载饿了么 ui 框架，这个框架是 PC 端的
$ cnpm install iview --save # 下载 iview 这个 ui 框架，框架都是选择的，选择其一即可。
$ cnpm install vux --save   # 下载 vux 这个 ui 框架，这个框架是移动端的
$ cnpm install mint-ui --save # 下载饿了么 ui 框架，这个框架是移动端的

$ cnpm install axios        # 下载前后端数据交互应用
$ yarn add axios            # 使用 yarn

$ npm install normalize.css # 浏览器兼容 css 文件
$ npm i v-charts echarts -S # 图表 ui 组件库
$ npm install --save dayjs  # 日期时间处理，dayjs 库

# 开发过程

$ cnpm run build  #开发完之后，打包 disc 文件夹部署上线
```

**还可以引人其他的工具库:**

- [阿里图标：](http://www.iconfont.cn/home/index?spm=a313x.7781069.1998910419.2)内含千万字符实体图标选择使用
- [Lodash工具库：](http://liuxmoo.gofoer.com/2018/08/12/12-lodash1/)一套工具库，内部封装了很多字符串、数组、对象等常见数据类型的处理函数，方便我们处理js的各种类型数据

#### 3.1.3 vue 框架项目创建    TypeScript 项目 TypeScript 项目 TypeScript 项目!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

```BASH
$ vue init webpack  projectname  # 创建 vue 项目
$ cd  projectname  # 进入到项目目录
$ cnpm install  # 下载 vue 依赖包
$ cnpm run dev  # 获取访问端口：http://localhost:8080/,开发过程调试等工作
# http://0.0.0.0:4000  如果运行后得到的网址是这个，直接复制这个是打开是不行的，
# 127.0.0.1:4000 要换成这个去运行， 0.0.0.0  是没有的，
# 还不行的话，多试几遍，再是不行的话，看看是不是同时有别的的项目在运行，用了 4000 这个端口。

# 经过几次的项目创建，发现没有 run 之前安装 vuex ， ui 组件这些都没有成功，
# 非是要 run 之后再来安装这些依赖包，方可使用。所以还是先 run 一下，再安装下面的安装包吧。


$ cnpm install vuex          #下载 vuex 状态管理器（状态就是某种条件状态下的数据保存起来），
$ cnpm iinstall element-ui --save # 下载饿了么 ui 框架，这个框架是 PC 端的
$ cnpm install iview --save # 下载 iview 这个 ui 框架，框架都是选择的，选择其一即可。
$ cnpm install vux --save   # 下载 vux 这个 ui 框架，这个框架是移动端的
$ cnpm install mint-ui --save # 下载饿了么 ui 框架，这个框架是移动端的

$ cnpm install axios        # 下载前后端数据交互应用
$ yarn add axios            # 使用 yarn

$ npm install normalize.css # 浏览器兼容 css 文件
$ npm i v-charts echarts -S # 图表 ui 组件库
$ npm install --save dayjs  # 日期时间处理，dayjs 库

# 开发过程

$ cnpm run build  #开发完之后，打包 disc 文件夹部署上线
```

### 3.2 初始化步骤

```BASH
vue init  模板名称  项目名称   # ①选择模板-创建文件夹：一直回车即可
cd 项目名称                   #  ②进入项目目录
cnpm install                  # ③根据 package.json 文件中
                              # 安装 dependencies 和 devDempendencies 字段中的模块
npm run dev                   # ④运行服务器:开发阶段测试
npm run build                 # ⑤打包项目 disc 文件：生产

```

```BASH
  再如：
  ①vue init webpack pos
  ②cnpm install
  ③cnpm run dev
  -----------------------------------------------
  ①或者手动建立一个文件夹 pos，命令行进入该文件夹，
  ②vue init webpack
  ③cnpm install
  ④cnpm run dev
  -----------------------------------------------
  ①再或者是命令行建立文件夹 mkdir pos，然后进去文件夹
  ②vue init webpack
  ③cnpm install
  ④cnpm run dev
```

### 3.3 查看各应用版本

```BASH
# 应用    命令
# node   node -v
# npm    npm -v
# cnpm   cnpm -v
# vue    vue -V   这个是大写的
```

### 3.4 安装过程爬的坑

#### 3.4.1 查看版本的坑

- -v 前面一定要有空格
- vue 的版本查看 -V 要是大写的才能识别，
- vue -V ，大写了还是无法识别版本，
        有可能是 npm 版本过低，可以使用 npm install -g npm 来更新版本

#### 3.4.2 旧版本缓存的坑

- vue-cli 的坑， 如果安装失败，
        可以使用 npm cache clean 清理缓存，然后再重新安装。后面的安装过程中，如有安装失败的情况，也需要先清理缓存  

#### 3.4.3 创建项目时出错 `chromedriver@2.41.0 install: node install.js`

$ vue init webpack

```bash
    # Installing project dependencies ...
    # ========================

    npm WARN deprecated browserslist@2.11.3: Browserslist 2 could fail on reading Browserslist >3.0 config used in other tools.
    npm WARN deprecated bfj-node4@5.3.1: Switch to the `bfj` package for fixes and new features!
    npm WARN deprecated browserslist@1.7.7: Browserslist 2 could fail on reading Browserslist >3.0 config used in other tools.
    npm WARN deprecated socks@1.1.10: If using 2.x branch, please upgrade to at least 2.1.6 to avoid a serious bug with socket data flow and an import issue introduced in 2.1.0
    npm WARN deprecated istanbul-lib-hook@1.2.1: 1.2.0 should have been a major version bump

    > chromedriver@2.41.0 install F:\qianduan_dir\00program\todolist\node_modules\chromedriver
    > node install.js

    Downloading https://chromedriver.storage.googleapis.com/2.41/chromedriver_win32.zip
    Saving to C:\Users\ADMINI~1\AppData\Local\Temp\chromedriver\chromedriver_win32.zip
    ChromeDriver installation failed Error with http(s) request: Error: read ECONNRESET
    npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\fsevents):
    npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

    npm ERR! code ELIFECYCLE
    npm ERR! errno 1
    npm ERR! chromedriver@2.41.0 install: `node install.js`
    npm ERR! Exit status 1
    npm ERR!
    npm ERR! Failed at the chromedriver@2.41.0 install script.
    npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

    npm ERR! A complete log of this run can be found in:
    npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-08-20T10_29_09_118Z-debug.log
```

chromedriver 是 google 为网站开发人员提供的自动化测试接口，是网站测试架构 selenium 的 chrome 基础部分，主要是通过 http 通信实现的。它是 selenium 和 浏览器进行通信的桥梁。

**填坑：**
首先出现这个错误是因为 Google 在国内无法使用，即使采用科学上网的方法也仍然无法获取文件。命令行中需要额外的来解决这个问题。这个坑不要解决也 ok ，因为它是自动化测试接口。

- **npm install chromedriver -g** 没有安装过 chromedriver 首选需要全局安装一下
- **npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver** 如果上面的代码不行，可以试试这个命令，使用淘宝镜像安装  

#### 3.4.4 克隆他人项目代码无法 run（webpack-dev-server 不是内部或外部命令）

cnpm run dev 无法运行，webpack-dev-server 不是内部或外部命令，也不是可运行的程序或批处理文件

```bash
    λ cnpm run dev

    > todolist@1.0.0 dev F:\qianduan_dir\00program\todolist
    > webpack-dev-server --inline --progress --config build/webpack.dev.conf.js

    module.js:549
        throw err;
        ^
    Error: Cannot find module 'concat-map'
        at Function.Module._resolveFilename (module.js:547:15)
        at Function.Module._load (module.js:474:25)
        at Module.require (module.js:596:17)
        at require (internal/module.js:11:18)
        at Object.<anonymous> (F:\qianduan_dir\00program\todolist\node_modules\brace-expansion\index.js:1:79)
        at Module._compile (module.js:652:30)
        at Object.Module._extensions..js (module.js:663:10)
        at Module.load (module.js:565:32)
        at tryModuleLoad (module.js:505:12)
        at Function.Module._load (module.js:497:3)
    npm ERR! code ELIFECYCLE
    npm ERR! errno 1
    npm ERR! todolist@1.0.0 dev: `webpack-dev-server --inline --progress --config build/webpack.dev.conf.js`
    npm ERR! Exit status 1
    npm ERR!
    npm ERR! Failed at the todolist@1.0.0 dev script.
    npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

    npm ERR! A complete log of this run can be found in:
    npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-08-20T11_51_01_114Z-debug.log
```

**填坑：**
依赖包是需要重新安装的，我们需要 `cnpm install` 下载项目的依赖包
一般来说别人的仓库文件是不会上传 node-modules 文件的，如果上传者没有把这个文件删除，我们需要先删除这个文件夹。再 `cnpm install` 下载项目的依赖包，重新生成正确的 node-modules 文件，

#### 3.4.5 热更新报错 log.error('[WDS] Errors while compiling. Reload prevented.')

```BASH
index.js?bed3:161 [WDS] Errors while compiling. Reload prevented.
```

WDS 其实是 ebpack-dev-serverwebpack 的意思，用来实现自动刷新的。

先看看自己的项目是不是没有 cnpm run dev ，如果已经运行，你在Vue组件进行频繁刷新时，如果没有安装 Webpack，虽然页面可以正常显示，但是控制台会在你每次刷新时就报错。解决方法是：在开发目录下安装 Webpack，命令为 npm install webpack-dev-server --save-dev 即可，安装完成之后会在 node_modules/bin 下找到。此时重新打开工程，命令为：npm run dev，即可解决热更新报错问题。

如果还是不正确那么就是创建项目的时候有了其他的错误，比如创建步骤导致的错误，重新创建一个项目目录好了。

#### 3.4.6

```TEXT
content.js:1 [Violation] Added non-passive event listener to a scroll-blocking 'touchmove' event. Consider marking event handler as 'passive' to make the page more responsive. See https://www.chromestatus.com/feature/5745543795965952
```

#### 3.4.7 依赖包出错无法run

```TEXT
没有给这些选项指定值：config-name, context, entry, module-bind, module-bind-post, module-bind-pre, output-path, output-filename, output-chunk-filename, output-source-map-filename, output-public-path, output-jsonp-function, output-library, output-library-target, records-input-path, records-output-path, records-path, define, target, watch-aggregate-timeout, devtool, resolve-alias, resolve-extensions, resolve-loader-alias, optimize-max-chunks, optimize-min-chunk-size, prefetch, provide, plugin, open-page
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! love@1.0.0 dev: `webpack-dev-server --inline --progress --config build/webpack.dev.conf.js`
npm ERR! Exit status 1
npm ERR!
npm ERR! Failed at the love@1.0.0 dev script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.
npm ERR! A complete log of this run can be found in:
```

有可能是 webpack 除了新版本，有 bug 了，之前的 2.10.0 版本就出现过 bug ，但是先不要考虑这个原因。

- 首先看下 package.json 文件中我们的 webpack 的版本。上网搜一下是不是 bug
- 重新安装依赖包
    删除掉项目中的 node-modules 文件夹
    清除缓存：`npm cache clean`
    安装依赖：`cnpm install`

如果知道是版本出错，卸载版本，下载可以使用的版本。

```bash
  npm remove webpack-dev-server
  npm install webpack-dev-server@2.9.1  // 这里假设是要下载 2.9.1 版本
  npm run dev
```

#### 3.4.8 vux安装出错

```TEXT
λ npm install vux --save
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\web-vue\musiccloud\node_modules\ajv\node_modules\co
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\web-vue\musiccloud\node_modules\globby\node_modules\object-assign
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\web-vue\musiccloud\node_modules\globby\node_modules\pinkie-promise
npm ERR! path F:\qianduan_dir\00program\web-vue\musiccloud\node_modules\ajv\node_modules\co
npm ERR! code ENOENT
npm ERR! errno -4058
npm ERR! syscall access
npm ERR! enoent ENOENT: no such file or directory, access 'F:\qianduan_dir\00program\web-vue\musiccloud\node_modules\ajv\node_modules\co'
npm ERR! enoent This is related to npm not being able to find a file.
npm ERR! enoent

npm ERR! A complete log of this run can be found in:
npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-09-30T15_57_14_849Z-debug.log
```

#### 3.4.9、卸载 vue 项目中的依赖出错

```bash
$ cnpm uninstall xxx --save
后者是 remove 也是一样的错误
```

```TEXT
λ cnpm uninstall vux --save
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\web-vue\musiccloud\node_modu
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\web-vue\musiccloud\node_modu
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\web-vue\musiccloud\node_modu
npm ERR! path F:\qianduan_dir\00program\web-vue\musiccloud\node_modules\ajv\node_modules\co
npm ERR! code ENOENT
npm ERR! errno -4058
npm ERR! syscall access
npm ERR! enoent ENOENT: no such file or directory, access 'F:\qianduan_dir\00program\web-vue\musiccloud\
npm ERR! enoent This is related to npm not being able to find a file.
npm ERR! enoent
npm ERR! A complete log of this run can be found in:
npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-09-30T16_09_50_845Z-debug.log  
```

报错说不存在这个文件夹。怎么解决？？？？？？？

## 四、框架结构详解

由于版本实时更新和你选择安装的不同（这里列出的是模板为 webpack 的目录结构），所以你看到的有可能和下边的有所差别。上一章也说道，模板使用最多的就是 webpack，这章的结构也将讲解的是 webpack 模板创建初始化的项目。

```TEXT
.
|-- build                            // 项目构建 (webpack) 相关代码
|   |-- build.js                     // 生产环境构建代码
|   |-- check-version.js             // 检查 node、npm 等版本
|   |-- dev-client.js                // 热重载相关
|   |-- dev-server.js                // 构建本地服务器
    //webpack.dev.conf.js            // 构建本地服务器 新版本的服务器构建文件
|   |-- utils.js                     // 构建工具相关
|   |-- webpack.base.conf.js         // webpack 基础配置
|   |-- webpack.dev.conf.js          // webpack 开发环境配置
|   |-- webpack.prod.conf.js         // webpack 生产环境配置
|-- config                           // 项目开发环境配置
|   |-- dev.env.js                   // 开发环境变量
|   |-- index.js                     // 项目一些配置变量
|   |-- prod.env.js                  // 生产环境变量
|   |-- test.env.js                  // 测试环境变量
|-- src                              // 源码目录
|   |-- components                     // vue 公共组件
|   |-- store                          // vuex 的状态管理
|   |-- App.vue                        // 页面入口文件
|   |-- main.js                        // 程序入口文件，加载各种公共组件
|-- static                           // 静态文件，比如一些图片，json 数据等
|   |-- data                           // 群聊分析得到的数据用于数据可视化
|-- .babelrc                         // ES6 语法编译配置
|-- .editorconfig                    // 定义代码格式
|-- .gitignore                       // git 上传需要忽略的文件格式
|-- README.md                        // 项目说明
|-- favicon.ico                      //图标
|-- index.html                       // 入口页面
|-- package.json                     // 项目基本信息
```

### 4.1 .babelrc 文件

Babel 解释器的配置文件,存放在根目录下。Babel 是一个转码器，项目里需要用它将 ES6 代码转为 ES5 代码。如果你想了解更多，可以查看 babel 的知识。

```JSON
{
  //设定转码规则
  "presets": [
    ["env", { "modules": false }],
    "stage-2"
  ],
  //转码用的插件
  "plugins": ["transform-runtime"],
  "comments": false,
  //对 BABEL_ENV 或者 NODE_ENV 指定的不同的环境变量，进行不同的编译操作
  "env": {
    "test": {
      "presets": ["env", "stage-2"],
      "plugins": [ "istanbul" ]
    }
  }
}
```

### 4.2 package.json 文件

package.json 文件是项目根目录下的一个文件，定义该项目开发所需要的各种模块以及一些项目配置信息（如项目名称、版本、描述、作者等）。

```JSON
"scripts": {
        "dev": "node build/dev-server.js",
        "build": "node build/build.js"
      },
```

dependencies 字段和 devDependencies 字段

dependencies 字段指项目运行时所依赖的模块；
devDependencies 字段指定了项目开发时所依赖的模块；
在命令行中运行 npm install 命令，会自动安装 dependencies 和 devDempendencies 字段中的模块。

npm run build 命令后，在你的项目根目录生成了 dist 文件夹，这个文件夹里边就是我们要传到服务器上的文件。 dist 文件夹下目录包括：

- index.html 主页文件:因为我们开发的是单页 web 应用，所以说一般只有一个 html 文件。
- js         static 静态资源文件夹：里边 js、CSS 和一些图片。
- CSS

### 4.3 .editorconfig 文件

该文件定义项目的编码规范，编译器的行为会与 .editorconfig 文件中定义的一致，并且其优先级比编译器自身的设置要高，这在多人合作开发项目时十分有用而且必要。

```text
    root = true  
    [*]    // 对所有文件应用下面的规则
    charset = utf-8                    // 编码规则用 utf-8
    indent_style = space               // 缩进用空格
    indent_size = 2                    // 缩进数量为 2 个空格
    end_of_line = lf                   // 换行符格式
    insert_final_newline = true        // 是否在文件的最后插入一个空行
    trim_trailing_whitespace = true    // 是否删除行尾的空格
```

### 4.4 dev-server.js 文件

```JS
// 检查 Node 和 npm 版本
require('./check-versions')()

// 获取 config/index.js 的默认配置
var config = require('../config')

// 如果 Node 的环境无法判断当前是 dev / product 环境
// 使用 config.dev.env.NODE_ENV 作为当前的环境

if (!process.env.NODE_ENV) process.env.NODE_ENV = JSON.parse(config.dev.env.NODE_ENV)

// 使用 NodeJS 自带的文件路径工具
var path = require('path')

// 使用 express
var express = require('express')

// 使用 webpack
var webpack = require('webpack')

// 一个可以强制打开浏览器并跳转到指定 url 的插件
var opn = require('opn')

// 使用 proxyTable
var proxyMiddleware = require('http-proxy-middleware')

// 使用 dev 环境的 webpack 配置
var webpackConfig = require('./webpack.dev.conf')

// default port where dev server listens for incoming traffic

// 如果没有指定运行端口，使用 config.dev.port 作为运行端口
var port = process.env.PORT || config.dev.port

// Define HTTP proxies to your custom API backend
// https://github.com/chimurai/http-proxy-middleware

// 使用 config.dev.proxyTable 的配置作为 proxyTable 的代理配置
var proxyTable = config.dev.proxyTable

// 使用 express 启动一个服务
var app = express()

// 启动 webpack 进行编译
var compiler = webpack(webpackConfig)

// 启动 webpack-dev-middleware，将 编译后的文件暂存到内存中
var devMiddleware = require('webpack-dev-middleware')(compiler, {
  publicPath: webpackConfig.output.publicPath,
  stats: {
    colors: true,
    chunks: false
  }
})

// 启动 webpack-hot-middleware，也就是我们常说的 Hot-reload
var hotMiddleware = require('webpack-hot-middleware')(compiler)
// force page reload when html-webpack-plugin template changes
compiler.plugin('compilation', function (compilation) {
  compilation.plugin('html-webpack-plugin-after-emit', function (data, cb) {
    hotMiddleware.publish({ action: 'reload' })
    cb()
  })
})

// proxy api requests
// 将 proxyTable 中的请求配置挂在到启动的 express 服务上
Object.keys(proxyTable).forEach(function (context) {
  var options = proxyTable[context]
  if (typeof options === 'string') {
    options = { target: options }
  }
  app.use(proxyMiddleware(context, options))
})

// handle fallback for HTML5 history API
// 使用 connect-history-api-fallback 匹配资源，如果不匹配就可以重定向到指定地址
app.use(require('connect-history-api-fallback')())

// serve webpack bundle output
// 将暂存到内存中的 webpack 编译后的文件挂在到 express 服务上
app.use(devMiddleware)

// enable hot-reload and state-preserving
// compilation error display
// 将 Hot-reload 挂在到 express 服务上
app.use(hotMiddleware)

// serve pure static assets
// 拼接 static 文件夹的静态资源路径
var staticPath = path.posix.join(config.dev.assetsPublicPath, config.dev.assetsSubDirectory)
// 为静态资源提供响应服务
app.use(staticPath, express.static('./static'))

// 让我们这个 express 服务监听 port 的请求，并且将此服务作为 dev-server.js 的接口暴露
module.exports = app.listen(port, function (err) {
  if (err) {
    console.log(err)
    return
  }
  var uri = 'http://localhost:' + port
  console.log('Listening at ' + uri + '\n')

  // when env is testing, don't need open it
  // 如果不是测试环境，自动打开浏览器并跳到我们的开发地址
  if (process.env.NODE_ENV !== 'testing') {
    opn(uri)
  }
})
```

### 4.5 webpack.base.confg.js   webpack的基础配置文件

```JS
...
...
module.export = {
    // 编译入口文件
    entry: {},
    // 编译输出路径
    output: {},
    // 一些解决方案配置
    resolve: {},
    resolveLoader: {},
    module: {
        // 各种不同类型文件加载器配置
        loaders: {
        ...
        ...
        // js 文件用 babel 转码
        {
            test: /\.js$/,
            loader: 'babel',
            include: projectRoot,
            // 哪些文件不需要转码
            exclude: /node_modules/
        },
        ...
        ...
        }
    },
    // vue文件一些相关配置
    vue: {}
}
```

## 六、解读Vue-cli的模板 工作原理

- **index.html：**一个框架的网页入口就是根目录下的文件， //html
- **main.js：**html 文件其对应的 js 文件。                //js
- **APP.vue** 导出的组件提供，提供 main.js 引入           //html，js,CSS
- **index.js** 组件的路由设置，在 main.js 做全局引入,    //js
- **HelloWord.vue** 导出的组件提供，提供 APP.vue 引入     //html，js,CSS

### 6.1 index.html 项目 html 入口文件

```HTML
<!-- index.html -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>todo</title>
  </head>
  <body>
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>
```

### 6.2 main.js 项目 js 入口文件

```JS
//main.js
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false   //生产环境提示，这里设置成了 false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
```

从 main.js
文件可以看出，这个文件导入了 Vue.js 之外。还有
**APP.vue：** main.js 对应导入的组件：引进了 Ap p的组件和 App 的模板
**router.js：**main.js 对应的路由设置文件：[Vue-router 学习](http://liuxmoo.gofoer.com/2018/08/12/7-vue-router/)

### 6.3 APP.vue 入口文件 main.js 的导入组件模板

```HTML
<!-- APP.vue -->
<template>
  <div id="app">
    <img src="./assets/logo.png">
    <router-view/> <!-- 组件通过通过这个标签插入 app.vue 中 -->
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
  margin-top: 60px;
}
</style>
```

>app.vue 文件我们可以分成三部分解读，

- `<template></template>`标签包裹的内容：**template 模板**
    这是模板的 HTMLDom 结构，里边引入了一张图片和`<router-view></router-view>`标签，
    `<router-view>`标签说明使用了路由机制。我们会在以后专门拿出一篇文章讲 Vue-router。
    router-view 标签，（vue 内部定义的一个自定义组件），他默认代表的是“/”这个路径。 更新路由路径更新的就是这个部分的内容，其他内容是不变的。
- `<script></script>`标签包括的js内容：** script 标签**
    你可以在这里些一些页面的动态效果和Vue的逻辑代码。
- `<style></style>`标签包裹的css内容：** style 样式标签**
    这里就是你平时写的 CSS 样式，对页面样子进行装饰用的，
    需要特别说明的是你可以用`<style scoped></style>`来声明这些css样式只在本模板中起作用。
    有 scoped 代表此模式仅用于此组件，没有 scoped 代表应用于所有的组件。

### 6.4  组件 .vue 创建与路由设置 index.js

**router 文件夹下 index.js 文件**

```JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    }
  ]
})
```

**component 文件夹下创建其他的 .vue 文件**

```HTML
<template>
  <div id="xiaomi">
    {{mag}}
  </div>
</template>

<script>
  export default {
    name: 'HelloWorld'，
    data(){
      return{
        msg:'xiaomi'
      }
    }
  }
</script>

<style>

</style>
```

### 6.5  其他子组件创建与路由设置

**component 文件夹下创建其他的 .vue 文件。并在 index.js 设置路由**

与 6.4 节一样，都是创建一个 .vue 文件，然后再 router.js 中设置路由，通过 router-view 这个标签导入到其他的组件中。或者是 router-link 做页面切换。具体需要学习 vue-router 路由设置之后做更多的子组件。页面切换效果。

### 七、爬坑之旅

## 7.1 vue-cli 创建的项目中 APP.vue 文件中有设置 logo 以及 margin-top: 60px

这个是 vue 官方做的一个主页，自己用到的时候删除或者更新 helloworld.vue 文件，不要忘记 APP.vue 文件中也需要改写。

- 把不需要的 v 这个 logo 删掉，
- style 标签中的样式改写

```HTML
<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px; /*这行一定更记得删除或者*/
}
</style>
```

## 六、css 样式处理

### 6.1 .vue 文件导入外部样式 @import

```HTML
<style lang="scss">
  @import "assets/style/reset"; /* 样式一般放在与 .vue 文件同级目录，这样也好操作 */
  @import url("//at.alicdn.com/t/font_948116_ddr9s3usi5o.css"); /* 这里是外部链接 url 导入 */
</style>
```

### 6.2 在 vue 项目中 css 使用 scss 或者 LESS 处理

### 6.3 在 .vue 中同时使用 css 与 scss 或者 LESS

可以在一个文件夹中使用多个 `<style>` 标签。

```HTML
<style scoped lang="scss">
  @import "admin.scss";
</style>

<style lang="less">
</style>

<style>
  /* 不写就默认是 css */
</style>
  ```